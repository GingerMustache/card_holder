import 'dart:ui';

import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/services/secure_storage.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';

class LocaleClass {
  LocaleClass._();

  static Future<FlutterI18nDelegate> initLocaleDelegate() async {
    _initLocale();
    String? langLocal = await SecureStorage().read(SecureKeys.lang.name);

    return FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'en',
        basePath: 'assets/locale',
        decodeStrategies: [JsonDecodeStrategy()],
        forcedLocale: langLocal == '' ? null : Locale(langLocal),
      ),
    );
  }

  static Future<void> _initLocale() async {
    String lc = '';

    lc = await SecureStorage().read(SecureKeys.lang.name);

    if (lc.isEmpty) {
      final deviceLocale = await LocaleSettings.useDeviceLocale();
      lc = deviceLocale.languageCode;

      if (!['ru', 'en'].contains(lc)) lc = 'ru';
      await SecureStorage().write(key: SecureKeys.lang.name, value: lc);

      _setLocale(lc);
    }
  }

  static void _setLocale(String lc) => switch (lc) {
    'en' => LocaleSettings.setLocale(AppLocale.en),
    'ru' => LocaleSettings.setLocale(AppLocale.ru),
    _ => LocaleSettings.setLocale(AppLocale.ru),
  };
}
