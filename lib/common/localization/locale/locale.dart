import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/services/secure_storage.dart';

class LocaleClass {
  LocaleClass._();

  static Future<void> initLocale() async {
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
