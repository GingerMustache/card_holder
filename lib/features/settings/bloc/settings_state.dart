// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  const SettingsState({this.lang = 'en'});

  final String lang;

  @override
  List<Object?> get props => [lang];

  SettingsState copyWith({String? lang}) {
    return SettingsState(lang: lang ?? this.lang);
  }
}
