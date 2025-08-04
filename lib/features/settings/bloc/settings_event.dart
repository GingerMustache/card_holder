part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingChangeLangEvent extends SettingsEvent {
  final String lang;

  SettingChangeLangEvent({required this.lang});
}

class SettingInitEvent extends SettingsEvent {}
