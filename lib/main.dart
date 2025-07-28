// need to run dart run build_runner build
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/services/di_container/di_container.dart';
import 'package:flutter/material.dart';

void main() async {
  final DiContainerProvider diContainer = DiContainer();
  WidgetsFlutterBinding.ensureInitialized();
  final app = diContainer.makeApp();

  runApp(TranslationProvider(child: app));
}
