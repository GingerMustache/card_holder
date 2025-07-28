import 'package:flutter/material.dart';
import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/routing/routes.dart';

abstract class DiContainerProvider {
  Widget makeApp();
}

class DiContainer implements DiContainerProvider {
  ScreenFactory _makeScreenFactory() => ScreenFactory(diContainer: this);
  MyAppNavigation _makeRouter() =>
      MainNavigation(screenFactory: _makeScreenFactory());

  @override
  Widget makeApp() => MyApp(navigation: _makeRouter());

  DiContainer();
}
