// need to run dart run build_runner build
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/di_container/di_container.dart';
import 'package:card_holder/common/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart'
    show FlutterI18nDelegate;
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart'
    show JsonDecodeStrategy;
import 'package:flutter_i18n/loaders/file_translation_loader.dart'
    show FileTranslationLoader;

void main() async {
  LocaleClass.initLocale();
  String? langLocal = await SecureStorage().read(SecureKeys.lang.name);

  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'en',
      basePath: 'assets/locale',
      decodeStrategies: [JsonDecodeStrategy()],
      forcedLocale: langLocal == '' ? null : Locale(langLocal),
    ),
  );
  final DiContainerProvider diContainer = DiContainer();
  WidgetsFlutterBinding.ensureInitialized();
  final app = diContainer.makeApp(flutterI18nDelegate);

  runApp(TranslationProvider(child: app));
}
