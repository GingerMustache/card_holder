part of 'cards_bloc.dart';

sealed class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object?> get props => [];
}

class CardsFetchCardsEvent extends CardsEvent {}

class CardsOpenCardEvent extends CardsEvent {
  final int? id;
  final int index;

  const CardsOpenCardEvent({required this.id, required this.index});
  @override
  List<Object?> get props => [id, index];
}

class CardsAddCardEvent extends CardsEvent {
  final String name;
  final String code;
  final int color;
  final Completer<DataBaseCard> completer;

  const CardsAddCardEvent({
    required this.code,
    required this.name,
    required this.color,
    required this.completer,
  });
  @override
  List<Object?> get props => [code, name, color];
}

class CardsUpdateCardEvent extends CardsEvent {
  final String? name;
  final String? code;
  final Completer<DataBaseCard>? completer;

  const CardsUpdateCardEvent({
    required this.name,
    required this.code,
    this.completer,
  });
  @override
  List<Object?> get props => [name];
}
