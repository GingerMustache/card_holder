// need to run dart run build_runner build
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/di_container/di_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DiContainerProvider diContainer = DiContainer();
  final flutterI18nDelegate = await LocaleClass.initLocaleDelegate();
  final app = diContainer.makeApp(flutterI18nDelegate);

  runApp(TranslationProvider(child: app));
}
