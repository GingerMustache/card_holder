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
