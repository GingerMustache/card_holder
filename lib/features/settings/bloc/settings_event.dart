part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingChangeLangEvent extends SettingsEvent {
  final String lang;

  SettingChangeLangEvent({required this.lang});
}

class SettingChangeThemeEvent extends SettingsEvent {
  final String theme;

  SettingChangeThemeEvent({required this.theme});
}

class SettingInitEvent extends SettingsEvent {}
