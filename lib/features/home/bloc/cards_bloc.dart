import 'dart:async' show Completer;

import 'package:bloc/bloc.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/repositories/card_repository.dart';
import 'package:card_holder/common/services/local_crud/crud_exceptions.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:equatable/equatable.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final CardRepository _cardRepo;

  CardsBloc({required CardRepository cardRepo})
    : _cardRepo = cardRepo,
      super(CardsState()) {
    on<CardsFetchCardsEvent>(_onFetchCards);
    on<CardsOpenCardEvent>(_onOpenCard);
    on<CardsAddCardEvent>(_onAddCards);
    on<CardsUpdateCardEvent>(_onUpdateCards);
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

  _onAddCards(CardsAddCardEvent event, Emitter<CardsState> emit) async {
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
        final updatedCard = card.copyWith(code: code, name: name);

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
}
