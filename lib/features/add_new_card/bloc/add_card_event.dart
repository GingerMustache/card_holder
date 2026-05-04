part of 'add_card_bloc.dart';

abstract class BlocEventAbstract {}

sealed class CreateCardEvent extends Equatable implements BlocEventAbstract {
  const CreateCardEvent();
}

class CreateCardChangeCodeEvent extends CreateCardEvent {
  final String code;
  const CreateCardChangeCodeEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class CreateCardInitEvent extends CreateCardEvent {
  final List<ShopTemplate> templates;
  const CreateCardInitEvent(this.templates);

  @override
  List<Object?> get props => [templates];
}

class CreateCardChangeColorEvent extends CreateCardEvent {
  final int color;
  const CreateCardChangeColorEvent(this.color);

  @override
  List<Object?> get props => [color];
}

class CreateCardSetInitTemplateEvent extends CreateCardEvent {
  final int? cardColor;
  final String? cardName;
  final String? svgUrl;
  final double? logoSize;
  final Completer? completer;

  const CreateCardSetInitTemplateEvent({
    this.cardColor,
    this.cardName,
    this.svgUrl,
    this.logoSize,
    this.completer,
  });

  @override
  List<Object?> get props => [cardColor, cardName, svgUrl, logoSize, completer];
}

class CreateCardChangeNameEvent extends CreateCardEvent {
  const CreateCardChangeNameEvent(this.name);
  final String name;

  @override
  List<Object?> get props => [name];
}

class CreateCardSearchEvent extends CreateCardEvent {
  const CreateCardSearchEvent(this.barcodes);
  final BarcodeCapture barcodes;

  @override
  List<Object?> get props => [barcodes];
}

class CreateCardChangeMarkTapEvent extends CreateCardEvent {
  const CreateCardChangeMarkTapEvent();

  @override
  List<Object?> get props => [];
}

class CreateCardResumeCameraEvent extends CreateCardEvent {
  const CreateCardResumeCameraEvent();

  @override
  List<Object?> get props => [];
}

class CreateCardSearchTemplateEvent extends CreateCardEvent {
  const CreateCardSearchTemplateEvent(this.text);

  final String? text;

  @override
  List<Object?> get props => [text];
}
