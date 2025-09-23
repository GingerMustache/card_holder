part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {}

class SettingChangeLangEvent extends SettingsEvent {
  final String lang;

  SettingChangeLangEvent({required this.lang});

  @override
  List<Object?> get props => [lang];
}

class SettingChangeThemeEvent extends SettingsEvent {
  final ThemeMode theme;

  SettingChangeThemeEvent({required this.theme});
  @override
  List<Object?> get props => [theme];
}

class SettingInitEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class SettingSearchEvent extends SettingsEvent {
  final String? query;

  SettingSearchEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
