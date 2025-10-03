// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async' show Completer;

import 'package:bloc/bloc.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/helpers/converter/convert_helper.dart';
import 'package:card_holder/common/helpers/converter/exceptions/image_helper_exceptions.dart';
import 'package:card_holder/common/mixins/event_transformer_mixin.dart';
import 'package:card_holder/common/repositories/card_repository.dart';
import 'package:card_holder/common/repositories/file_pick_repository.dart';
import 'package:card_holder/common/repositories/shared_repository.dart';
import 'package:card_holder/common/services/file_pick/exceptions/file_pick_service_exceptions.dart';
import 'package:card_holder/common/services/local_crud/exceptions/crud_exceptions.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/common/services/share/exceptions/shared_service_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState>
    with EventTransformerMixin {
  final CardRepository _cardRepo;
  final FilePickRepository _filePickRepository;
  final ConvertHelper _convertHelper;

  CardsBloc({
    required CardRepository cardRepo,
    required ConvertHelper imageConvertHelper,
    required ShareRepository shareRepository,
    required FilePickRepository filePickRepository,
  }) : _cardRepo = cardRepo,
       _convertHelper = imageConvertHelper,
       _filePickRepository = filePickRepository,

       super(CardsState()) {
    on<CardsFetchCardsEvent>(_onFetchCards);
    on<CardsOpenCardEvent>(_onOpenCard);
    on<CardsAddCardEvent>(_onAddCard);
    on<CardsAddFileCardEvent>(_onAddFileCards);
    on<CardsUpdateCardEvent>(_onUpdateCards);
    on<CardsSearchEvent>(_onCardSearch, transformer: debounceRestartable());
    on<CardsShareImageEvent>(_onCardShareImage);
    on<CardsShareFileEvent>(_onCardShareFile);
    on<CardsShareAllCardsEvent>(_onShareAllCards);
  }
  _onFetchCards(CardsFetchCardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final cards = await _cardRepo.getCards();

    cards.fold(
      (Exception e) {
        if (e is LocalDataBaseException) {
          emit(state.copyWith(cards: state.cards, isLoading: false, error: e));
        }
      },

      (List<DataBaseCard> cards) =>
          emit(state.copyWith(cards: cards, isLoading: false)),
    );
  }

  _onOpenCard(CardsOpenCardEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _cardRepo.openCard(id: event.id ?? 0);

    final cards = state.cards;

    result.fold(
      (Exception e) {
        if (e is LocalDataBaseException) {
          emit(state.copyWith(cards: state.cards, isLoading: false, error: e));
          event.completer.completeError(e);
        }
      },

      (DataBaseCard card) {
        card = card.copyWith(usagePoint: card.usagePoint + 1);
        cards[event.index] = card;
        cards.sort((a, b) => b.usagePoint.compareTo(a.usagePoint));

        emit(state.copyWith(currentCard: card, cards: cards, isLoading: false));
        event.completer.complete(card);
      },
    );
  }

  _onAddCard(CardsAddCardEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _cardRepo.createCard(
      code: event.code,
      name: event.name,
      color: event.color,
    );
    result.fold(
      (Exception e) {
        if (e is LocalDataBaseException) {
          emit(state.copyWith(cards: state.cards, isLoading: false));
          event.completer.completeError(e);
        }
      },

      (DataBaseCard card) {
        emit(state.copyWith(cards: [...state.cards, card], isLoading: false));
        event.completer.complete(card);
      },
    );
  }

  _onAddFileCards(CardsAddFileCardEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _filePickRepository.pickJsonFile();

    await result.fold(
      (Exception e) {
        if (e is FilePickException) {
          emit(state.copyWith(cards: state.cards, isLoading: false));
          event.completer.completeError(e);
        }
      },
      // right
      (FilePickerResult? pickerResult) async {
        if (pickerResult != null) {
          final jsonResult = await _convertHelper.jsonFromFile(
            filePath: pickerResult.files.single.path ?? '',
          );

          jsonResult.fold(
            (Exception e) {
              if (e is JsonFromFileFailed) {
                emit(state.copyWith(cards: state.cards, isLoading: false));
                event.completer.completeError(e);
              }
            },
            // right
            (Map<String, dynamic> cardMap) {
              add(
                CardsAddCardEvent(
                  code: cardMap['code'],
                  name: cardMap['name'],
                  color: cardMap['color'] ?? 0x00000000,
                  completer: event.completer,
                ),
              );
            },
          );
        }
      },
    );
  }

  _onUpdateCards(CardsUpdateCardEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final String code =
        event.code.notNull.isNotEmpty
            ? event.code.notNull
            : state.currentCard?.code ?? '';
    final String name =
        event.name.notNull.isNotEmpty
            ? event.name.notNull
            : state.currentCard?.name ?? '';

    final result = await _cardRepo.updateCard(
      id: state.currentCard!.id,
      code: code,
      name: name,
      color: event.color,
    );

    result.fold(
      (Exception e) {
        if (e is LocalDataBaseException) {
          emit(state.copyWith(cards: state.cards, isLoading: false));
          event.completer?.completeError(e);
        }
      },

      (DataBaseCard card) {
        final cards = state.cards;
        final currentCardIndex = state.cards.indexWhere((e) => e.id == card.id);
        final updatedCard = card.copyWith(
          code: code,
          name: name,
          color: event.color,
        );

        cards[currentCardIndex] = updatedCard;

        emit(
          state.copyWith(
            cards: cards,
            currentCard: updatedCard,
            isLoading: false,
          ),
        );
        event.completer?.complete(card);
      },
    );
  }

  _onCardSearch(CardsSearchEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<DataBaseCard> cards = state.cards;

    if (event.text != null && event.text!.isNotEmpty) {
      final List<DataBaseCard> foundCards =
          cards
              .where((element) => element.name.contains(event.text ?? ''))
              .toList();

      foundCards.isEmpty
          ? emit(
            state.copyWith(
              isLoading: false,
              cards: state.cards,
              searchListCards: [],
            ),
          )
          : emit(state.copyWith(isLoading: false, searchListCards: foundCards));
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          cards: state.cards,
          searchListCards: [],
        ),
      );
    }
  }

  _onCardShareImage(
    CardsShareImageEvent event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _convertHelper.getImagePathFromRenderObject(
      event.barcodeKey,
    );

    await result.fold(
      (Exception e) {
        if (e is RenderObjectNotConverted) {
          emit(state.copyWith(cards: state.cards, isLoading: false));
          // event.completer?.completeError(e);
        }
      },

      (String filePath) async {
        _shareCardNet(filePath, state.currentCard?.name ?? '');

        // event.completer?.complete(card);
      },
    );
  }

  _onCardShareFile(CardsShareFileEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final jsonList = {
      'code': state.currentCard?.code ?? '',
      'name': state.currentCard?.name ?? '',
      'color': state.currentCard?.color ?? 0x00000000,
    };

    final result = await _convertHelper.getJsonFilePath(
      jsonList: jsonList,
      fileName: '${state.currentCard?.name}.json',
    );

    await result.fold(
      (Exception e) {
        if (e is JsonFileNotConverted) {
          emit(state.copyWith(cards: state.cards, isLoading: false));
          // event.completer?.completeError(e);
        }
      },
      (String filePath) async {
        _shareCardNet(filePath, state.currentCard?.name ?? '');

        // event.completer?.complete(card);
      },
    );
  }

  // others func
  Future<void> _shareCardNet(String filePath, String cardName) async {
    final shareResult = await _cardRepo.shareCardNet(
      paths: [filePath],
      text: cardName,
    );
    shareResult.fold(
      (Exception e) {
        if (e is FileSharedException) {
          emit(state.copyWith(cards: state.cards, isLoading: false));
        }
      },
      (_) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  _onShareAllCards(
    CardsShareAllCardsEvent event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
  }
}
