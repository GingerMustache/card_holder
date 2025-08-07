// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  const SettingsState({this.lang = 'en', this.theme = ThemeMode.light});

  final String lang;
  final ThemeMode theme;

  @override
  List<Object?> get props => [lang, theme];

  SettingsState copyWith({String? lang, ThemeMode? theme}) {
    return SettingsState(lang: lang ?? this.lang, theme: theme ?? this.theme);
  }
}
