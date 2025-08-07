import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart'
    show FlutterI18nDelegate;

abstract class DiContainerProvider {
  Widget makeApp(FlutterI18nDelegate flutterI18nDelegate);
}

class DiContainer implements DiContainerProvider {
  ScreenFactory _makeScreenFactory() => ScreenFactory(diContainer: this);
  MyAppNavigation _makeRouter() =>
      MainNavigation(screenFactory: _makeScreenFactory());

  @override
  Widget makeApp(FlutterI18nDelegate flutterI18nDelegate) => MyApp(
    navigation: _makeRouter(),
    flutterI18nDelegate: flutterI18nDelegate,
  );

  DiContainer();
}
