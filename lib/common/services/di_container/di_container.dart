import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/routing/routes.dart';
import 'package:flutter/material.dart';

abstract class DiContainerProvider {
  Widget makeApp();
}

class DiContainer implements DiContainerProvider {
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);
  ScreenFactory _makeScreenFactory() =>
      ScreenFactory(diContainer: this, themeMode: themeMode);
  MyAppNavigation _makeRouter() =>
      MainNavigation(screenFactory: _makeScreenFactory());

  @override
  Widget makeApp() => MyApp(navigation: _makeRouter(), themeMode: themeMode);

  DiContainer();
}
