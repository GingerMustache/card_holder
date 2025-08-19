import 'dart:async' show Completer;

import 'package:bloc/bloc.dart';
import 'package:card_holder/common/services/local_crud/card_service.dart';
import 'package:equatable/equatable.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final CardServiceAbstract _cardService;
  CardsBloc({required CardServiceAbstract cardService})
    : _cardService = cardService,
      super(CardsState()) {
    on<CardsFetchCardsEvent>(_onFetchCards);
    on<CardsOpenCardEvent>(_onOpenCard);
    on<CardsAddCardEvent>(_onAddCards);
  }
  _onFetchCards(CardsFetchCardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final cards = await _cardService.getAllCards();

    emit(state.copyWith(cards: cards, isLoading: false));
  }

  _onOpenCard(CardsOpenCardEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final currentCard = await _cardService.openCard(id: event.id ?? 0);

    final cards = state.cards;

    cards[event.index] = currentCard.copyWith(
      usagePoint: currentCard.usagePoint + 1,
    );
    cards.sort((a, b) => b.usagePoint.compareTo(a.usagePoint));

    emit(
      state.copyWith(currentCard: currentCard, cards: cards, isLoading: false),
    );
  }

  _onAddCards(CardsAddCardEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final card = await _cardService.createCard(
        code: event.code,
        name: event.name,
      );

      emit(state.copyWith(cards: [...state.cards, card], isLoading: false));
      event.completer.complete(card);
    } catch (e, st) {
      emit(state.copyWith(cards: state.cards, isLoading: false));
      event.completer.completeError(e, st);
    }
  }
}
