part of 'create_card_bloc.dart';

sealed class CreateCardEvent extends Equatable {}

class CreateCardChangeCodeEvent extends CreateCardEvent {
  CreateCardChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}

class CreateCardChangeNameEvent extends CreateCardEvent {
  CreateCardChangeNameEvent(this.name);
  final String name;

  @override
  List<Object?> get props => [name];
}

class CreateCardSearchEvent extends CreateCardEvent {
  CreateCardSearchEvent(this.barcodes);
  final BarcodeCapture barcodes;

  @override
  List<Object?> get props => [barcodes];
}
