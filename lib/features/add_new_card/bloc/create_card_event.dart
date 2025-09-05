part of 'create_card_bloc.dart';

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
  const CreateCardChangeColorEvent(this.intColor);
  final int intColor;

  @override
  List<Object?> get props => [intColor];
}

class CreateCardSetInitColorEvent extends CreateCardEvent {
  const CreateCardSetInitColorEvent();

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
