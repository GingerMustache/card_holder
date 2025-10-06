import 'package:bloc/bloc.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:card_holder/common/services/local_storage/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LocalStorageService _localStorage;
  List<String> get _settingItems => [
    t.system.theme.all,
    t.system.lang.all,
    t.system.bright.all,
    t.system.share.all,
    'Security',
    'Display',
    'Help & Support',
    'About',
    'Logout',
  ];

  SettingsBloc({required LocalStorageService localStorage})
    : _localStorage = localStorage,

      super(SettingsState()) {
    on<SettingChangeLangEvent>(_onChangeLang);
    on<SettingChangeThemeEvent>(_onChangeTheme);
    on<SettingInitEvent>(_onInit);
    on<SettingSearchEvent>(_onSettingSearch);
    on<SettingChangeBrightnessEvent>(_onBrightnessChange);
  }

  _onInit(SettingInitEvent event, Emitter<SettingsState> emit) async {
    final currentLang = await _localStorage.read(
      SecureKeys.lang.name,
      insteadValue: 'ru',
    );

    final currentTheme =
        await _localStorage.read(SecureKeys.theme.name) == 'dark'
            ? ThemeMode.dark
            : ThemeMode.light;

    final currentBrightnessMode =
        await _localStorage.read(SecureKeys.brightness.name) == 'handle'
            ? BrightnessMode.handle
            : BrightnessMode.auto;

    emit(
      state.copyWith(
        lang: currentLang,
        theme: currentTheme,
        brightnessMode: currentBrightnessMode,
        settingItems: _settingItems,
      ),
    );
  }

  _onChangeLang(
    SettingChangeLangEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final isRu = event.lang == 'ru';

    await _localStorage.write(key: SecureKeys.lang.name, value: event.lang);
    await LocaleSettings.setLocale(isRu ? AppLocale.ru : AppLocale.en);

    emit(state.copyWith(lang: event.lang, settingItems: _settingItems));
  }

  _onBrightnessChange(
    SettingChangeBrightnessEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _localStorage.write(
      key: SecureKeys.brightness.name,
      value: event.mode.name.toString(),
    );

    emit(state.copyWith(brightnessMode: event.mode));
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
