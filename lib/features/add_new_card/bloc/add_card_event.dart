part of 'add_card_bloc.dart';

sealed class AddCardEvent extends Equatable {}

class AddCardChangeCodeEvent extends AddCardEvent {
  AddCardChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}

class AddCardChangeNameEvent extends AddCardEvent {
  AddCardChangeNameEvent(this.name);
  final String name;

  @override
  List<Object?> get props => [name];
}
