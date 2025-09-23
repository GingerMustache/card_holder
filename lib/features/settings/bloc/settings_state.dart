// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  const SettingsState({
    this.lang = 'en',
    this.theme = ThemeMode.light,
    this.settingItems = const [],
    this.searchItems = const [],
  });

  final String lang;
  final ThemeMode theme;
  final List<String> settingItems;
  final List<String> searchItems;

  @override
  List<Object?> get props => [lang, theme, settingItems, searchItems];

  SettingsState copyWith({
    String? lang,
    ThemeMode? theme,
    List<String>? settingItems,
    List<String>? searchItems,
  }) {
    return SettingsState(
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      settingItems: settingItems ?? this.settingItems,
      searchItems: searchItems ?? this.searchItems,
    );
  }
}
