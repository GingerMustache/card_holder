import 'package:bloc/bloc.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/local_storage/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LocalStorageService _localStorage;

  SettingsBloc({required LocalStorageService localStorage})
    : _localStorage = localStorage,

      super(SettingsState()) {
    on<SettingChangeLangEvent>(_onChangeLang);
    on<SettingChangeThemeEvent>(_onChangeTheme);
    on<SettingInitEvent>(_onInit);
    on<SettingSearchEvent>(_onSettingSearch);
  }

  _onInit(SettingInitEvent event, Emitter<SettingsState> emit) async {
    final currentLang = LocaleClass.currentLang;
    final currentTheme =
        await _localStorage.read(SecureKeys.theme.name) == 'dark'
            ? ThemeMode.dark
            : ThemeMode.light;
    final settingItems = [
      t.system.theme.all,
      t.system.lang.all,
      'brightness',
      'Privacy',
      'Security',
      'Display',
      'Help & Support',
      'About',
      'Logout',
    ];

    emit(
      state.copyWith(
        lang: currentLang,
        theme: currentTheme,
        settingItems: settingItems,
      ),
    );
  }

  _onChangeLang(
    SettingChangeLangEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final isRu = event.lang == 'ru';

    await _localStorage.write(key: SecureKeys.lang.name, value: event.lang);
    LocaleSettings.setLocale(isRu ? AppLocale.ru : AppLocale.en);

    emit(state.copyWith(lang: event.lang));
  }

  _onChangeTheme(
    SettingChangeThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _localStorage.write(
      key: SecureKeys.theme.name,
      value: event.theme.name,
    );

    emit(state.copyWith(theme: event.theme));
  }

  _onSettingSearch(
    SettingSearchEvent event,
    Emitter<SettingsState> emit,
  ) async {
    List<String> settings = state.settingItems;

    if (event.query != null && event.query!.isNotEmpty) {
      final List<String> foundSetting =
          settings
              .where((element) => element.contains(event.query ?? ''))
              .toList();

      foundSetting.isEmpty
          ? emit(state.copyWith(settingItems: state.settingItems))
          : emit(state.copyWith(searchItems: foundSetting));
    } else {
      emit(state.copyWith(settingItems: state.settingItems, searchItems: []));
    }
  }
}
