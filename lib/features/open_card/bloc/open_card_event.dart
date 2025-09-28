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

class OpenCardInitEvent extends OpenCardEvent {
  const OpenCardInitEvent(this.curCard, this.brightnessMode);
  final DataBaseCard curCard;
  final BrightnessMode brightnessMode;

  @override
  List<Object?> get props => [curCard, brightnessMode];
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
  const OpenCardChangeBrightnessEvent({this.dismissSheet = false});
  final bool dismissSheet;

  @override
  List<Object?> get props => [dismissSheet];
}
