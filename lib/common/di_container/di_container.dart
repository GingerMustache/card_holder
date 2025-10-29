import 'package:card_holder/common/helpers/converter/convert_helper.dart';
import 'package:card_holder/common/helpers/converter/text_field_validator/text_field_validator.dart';
import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/repositories/card_repository.dart';
import 'package:card_holder/common/repositories/file_pick_repository.dart';
import 'package:card_holder/common/repositories/shared_repository.dart';
import 'package:card_holder/common/routing/routes.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:card_holder/common/services/error_service/error_service.dart';
import 'package:card_holder/common/services/file_pick/file_pick_service.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/common/services/local_storage/secure_storage.dart';
import 'package:card_holder/common/services/share/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart'
    show FlutterI18nDelegate;

abstract class DiContainerProvider {
  Widget makeApp(FlutterI18nDelegate flutterI18nDelegate);
  CardServiceAbstract makeCardService();
  BrightnessService makeBrightnessService();
  ShareService makeShareService();
  FilePickService makeFilePickService();
  CardRepository makeCardRepository();
  ShareRepository makeShareRepository();
  FilePickRepository makeFilePickRepository();
  LocalStorageService makeLocalStorage();
  ConvertHelper makeImageConverterHelper();
  TextValidatorService makeTextValidatorService();
  MainErrorService makeErrorService();
}

class DiContainer implements DiContainerProvider {
  @override
  BrightnessService makeBrightnessService() => BrightnessServiceImpl();
  @override
  CardServiceAbstract makeCardService() => LocalCardService();
  @override
  ShareService makeShareService() => NetShareServiceImpl();
  @override
  FilePickService makeFilePickService() => NetFilePickServiceImpl();
  @override
  TextValidatorService makeTextValidatorService() => TextValidatorService();
  @override
  MainErrorService makeErrorService() => MainErrorService.instance;

  @override
  LocalStorageService makeLocalStorage() => SecureStorage();

  @override
  CardRepository makeCardRepository() => CardRepositoryImpl(
    localCardService: makeCardService(),
    netShareRepository: makeShareRepository(),
  );

  @override
  FilePickRepository makeFilePickRepository() =>
      FilePickRepositoryImpl(filePickService: makeFilePickService());

  @override
  ShareRepository makeShareRepository() =>
      ShareRepositoryImpl(shareService: makeShareService());

  ScreenFactory _makeScreenFactory() => ScreenFactory(diContainer: this);
  MyAppNavigation _makeRouter() =>
      MainNavigation(screenFactory: _makeScreenFactory());

  @override
  Widget makeApp(FlutterI18nDelegate flutterI18nDelegate) => MyApp(
    navigation: _makeRouter(),
    flutterI18nDelegate: flutterI18nDelegate,
  );

  DiContainer();

  @override
  ConvertHelper makeImageConverterHelper() => ConvertHelper();
}
