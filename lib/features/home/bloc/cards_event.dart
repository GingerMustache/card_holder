part of 'cards_bloc.dart';

sealed class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class CardsFetchCardsEvent extends CardsEvent {}
