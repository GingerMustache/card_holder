import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/repositories/card_repository.dart';
import 'package:card_holder/common/routing/routes.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/common/services/local_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart'
    show FlutterI18nDelegate;

abstract class DiContainerProvider {
  Widget makeApp(FlutterI18nDelegate flutterI18nDelegate);
  LocalStorageService makeLocalStorage();
  CardServiceAbstract makeCardService();
  CardRepository makeCardRepository();
}

class DiContainer implements DiContainerProvider {
  @override
  LocalStorageService makeLocalStorage() => SecureStorage();
  @override
  CardServiceAbstract makeCardService() => LocalCardService();

  @override
  CardRepository makeCardRepository() =>
      CardRepositoryImpl(localCardService: makeCardService());

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
