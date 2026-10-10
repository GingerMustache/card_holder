import 'package:card_holder/common/configs/setting_config.dart';
import 'package:card_holder/common/di_container/modules/di_module_helpers.dart';
import 'package:card_holder/common/di_container/modules/di_module_repository.dart';
import 'package:card_holder/common/di_container/modules/di_module_services.dart';
import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart'
    show FlutterI18nDelegate;

// di_container.dart
abstract interface class DiContainerProvider {
  DiModuleServices get services;
  DiModuleRepository get repositories;
  DiModuleHelpers get helpers;

  Future<SettingConfig> makeSettingConfig();
  Widget makeApp(FlutterI18nDelegate delegate, SettingConfig config);
}

final class DiContainer implements DiContainerProvider {
  DiContainer({DiModuleServices? services, DiModuleHelpers? helpers})
    : services = services ?? DiModuleServicesImpl(),
      helpers = helpers ?? DiModuleHelpersImpl();

  @override
  final DiModuleServices services;
  @override
  final DiModuleHelpers helpers;

  @override
  late final DiModuleRepository repositories = DiModuleRepositoryImpl(services);

  @override
  Future<SettingConfig> makeSettingConfig() =>
      SettingConfigImpl.fromLocalStorage(services.localStorage);

  @override
  Widget makeApp(FlutterI18nDelegate delegate, SettingConfig config) => MyApp(
    navigation: MainNavigation(screenFactory: ScreenFactory(diContainer: this)),
    flutterI18nDelegate: delegate,
    settingConfig: config,
  );
}
