part of 'open_card_bloc.dart';

sealed class OpenCardEvent extends Equatable implements BlocEventAbstract {
  const OpenCardEvent();
}

class OpenCardChangeNameEvent extends OpenCardEvent {
  const OpenCardChangeNameEvent(this.name);
  final String name;

  @override
  List<Object?> get props => [name];
}

class OpenCardChangeCodeEvent extends OpenCardEvent {
  const OpenCardChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}
