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
  final Completer<DataBaseCard> completer;

  const CardsOpenCardEvent({
    required this.id,
    required this.index,
    required this.completer,
  });
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
  final int color;
  final Completer<DataBaseCard>? completer;

  const CardsUpdateCardEvent({
    required this.name,
    required this.code,
    required this.color,
    this.completer,
  });
  @override
  List<Object?> get props => [name, code, color];
}

class CardsSearchEvent extends CardsEvent {
  final String? text;

  const CardsSearchEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class CardsShareEvent extends CardsEvent {
  final GlobalKey barcodeKey;
  final String cardName;

  const CardsShareEvent({required this.barcodeKey, required this.cardName});
  @override
  List<Object?> get props => [barcodeKey, cardName];
}
