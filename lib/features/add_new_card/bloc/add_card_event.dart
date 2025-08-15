part of 'add_card_bloc.dart';

sealed class AddCardEvent extends Equatable {}

class AddCardChangeCodeEvent extends AddCardEvent {
  AddCardChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}
