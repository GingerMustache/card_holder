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
  final CardCodeType cardCodeType;
  final String urlPath;
  final double logoSize;
  final Completer<DataBaseCard>? completer;

  const CardsAddCardEvent({
    required this.cardCodeType,
    required this.code,
    required this.name,
    required this.color,
    required this.urlPath,
    required this.logoSize,
    required this.completer,
  });
  @override
  List<Object?> get props => [
    code,
    name,
    color,
    urlPath,
    logoSize,
    cardCodeType,
  ];
}

class CardsDeleteCardEvent extends CardsEvent {
  final int id;
  final Completer? completer;

  const CardsDeleteCardEvent({required this.id, this.completer});
  @override
  List<Object?> get props => [id];
}

class CardsAddFileCardEvent extends CardsEvent {
  final Completer<DataBaseCard> completer;

  const CardsAddFileCardEvent({required this.completer});
  @override
  List<Object?> get props => [];
}

class CardsUpdateCardEvent extends CardsEvent {
  final String? name;
  final String? code;
  final int color;
  final String urlPath;
  final CardCodeType cardCodeType;
  final double logoSize;
  final Completer<DataBaseCard>? completer;

  const CardsUpdateCardEvent({
    required this.name,
    required this.code,
    required this.cardCodeType,
    required this.color,
    required this.urlPath,
    required this.logoSize,
    this.completer,
  });
  @override
  List<Object?> get props => [
    name,
    code,
    color,
    urlPath,
    logoSize,
    cardCodeType,
  ];
}

class CardsSearchEvent extends CardsEvent {
  final String? text;

  const CardsSearchEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class CardsShareImageEvent extends CardsEvent {
  final GlobalKey barcodeKey;
  final BuildContext ctx;

  const CardsShareImageEvent(this.ctx, {required this.barcodeKey});
  @override
  List<Object?> get props => [barcodeKey];
}

class CardsShareFileEvent extends CardsEvent {
  final BuildContext ctx;
  const CardsShareFileEvent(this.ctx);
  @override
  List<Object?> get props => [];
}

class CardsShareAllCardsEvent extends CardsEvent {
  final BuildContext ctx;

  const CardsShareAllCardsEvent(this.ctx);
  @override
  List<Object?> get props => [];
}
