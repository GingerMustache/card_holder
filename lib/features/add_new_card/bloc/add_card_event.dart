part of 'add_card_bloc.dart';

abstract class BlocEventAbstract {}

sealed class CreateCardEvent extends Equatable implements BlocEventAbstract {
  const CreateCardEvent();
}

class CreateCardChangeCodeEvent extends CreateCardEvent {
  const CreateCardChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}

class CreateCardChangeColorEvent extends CreateCardEvent {
  const CreateCardChangeColorEvent(this.color);
  final int color;

  @override
  List<Object?> get props => [color];
}

class CreateCardSetInitTemplateEvent extends CreateCardEvent {
  final int? cardColor;
  final String? cardName;
  final String? svgUrl;

  const CreateCardSetInitTemplateEvent({
    this.cardColor,
    this.cardName,
    this.svgUrl,
  });

  @override
  List<Object?> get props => [];
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
