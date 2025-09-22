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

class OpenCardSetCurrentCardEvent extends OpenCardEvent {
  const OpenCardSetCurrentCardEvent(this.curCard);
  final DataBaseCard curCard;

  @override
  List<Object?> get props => [curCard];
}

class OpenCardChangeCodeEvent extends OpenCardEvent {
  const OpenCardChangeCodeEvent(this.code);
  final String code;

  @override
  List<Object?> get props => [code];
}

class OpenCardChangeColorEvent extends OpenCardEvent {
  const OpenCardChangeColorEvent(this.color);
  final int color;

  @override
  List<Object?> get props => [color];
}

class OpenCardChangeMarkTapEvent extends OpenCardEvent {
  const OpenCardChangeMarkTapEvent();

  @override
  List<Object?> get props => [];
}

class OpenCardChangeBrightnessEvent extends OpenCardEvent {
  const OpenCardChangeBrightnessEvent();

  @override
  List<Object?> get props => [];
}
