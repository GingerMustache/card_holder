// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  const SettingsState({
    this.lang = 'ru',
    this.theme = ThemeMode.light,
    this.brightnessMode = BrightnessMode.auto,

    this.startApp = false,
    this.settingItems = const [],
    this.searchItems = const [],
  });

  final String lang;
  final ThemeMode theme;
  final BrightnessMode brightnessMode;
  final List<String> settingItems;
  final List<String> searchItems;
  final bool startApp;

  @override
  List<Object?> get props => [
    lang,
    startApp,
    theme,
    settingItems,
    searchItems,
    brightnessMode,
  ];

  SettingsState copyWith({
    String? lang,
    ThemeMode? theme,
    bool? startApp,
    BrightnessMode? brightnessMode,
    List<String>? settingItems,
    List<String>? searchItems,
  }) {
    return SettingsState(
      brightnessMode: brightnessMode ?? this.brightnessMode,
      lang: lang ?? this.lang,
      startApp: startApp ?? this.startApp,
      theme: theme ?? this.theme,
      settingItems: settingItems ?? this.settingItems,
      searchItems: searchItems ?? this.searchItems,
    );
  }
}
