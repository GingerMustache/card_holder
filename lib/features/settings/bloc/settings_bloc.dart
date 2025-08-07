import 'package:bloc/bloc.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<SettingChangeLangEvent>(_onChangeLang);
    on<SettingChangeThemeEvent>(_onChangeTheme);
    on<SettingInitEvent>(_onInit);
  }

  _onInit(SettingInitEvent event, Emitter<SettingsState> emit) async {
    final currentLang = LocaleClass.currentLang;

    emit(state.copyWith(lang: currentLang));
  }

  _onChangeLang(
    SettingChangeLangEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final isRu = event.lang == 'ru';

    await SecureStorage().write(key: SecureKeys.lang.name, value: event.lang);
    LocaleSettings.setLocale(isRu ? AppLocale.ru : AppLocale.en);

    emit(state.copyWith(lang: event.lang));
  }
}

_onChangeTheme(
  SettingChangeThemeEvent event,
  Emitter<SettingsState> emit,
) async {
  final isLight = event.theme == ThemeMode.light;

  await SecureStorage().write(
    key: SecureKeys.lang.name,
    value: event.theme.name,
  );
}
