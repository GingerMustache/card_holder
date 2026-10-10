import 'package:card_holder/common/configs/setting_config.dart';
import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/main_providers/bloc_providers.dart';
import 'package:card_holder/common/main_providers/repository_providers.dart';
import 'package:card_holder/common/services/error_service/error_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider;

void main() async {
  MainErrorService.instance.initialize();

  MainErrorService.instance.runGuarded(() async {
    final DiContainerProvider diContainer = DiContainer();

    final SettingConfig settingConfig = await diContainer.makeSettingConfig();
    final flutterI18nDelegate = await LocaleClass.initLocaleDelegate();

    final app = diContainer.makeApp(flutterI18nDelegate, settingConfig);

    runApp(
      TranslationProvider(
        child: MultiBlocProvider(
          providers: [
            ...RepositoryProviders(diContainer).list,
            ...BlocProviders(diContainer, settingConfig).list,
          ],
          child: app,
        ),
      ),
    );
  });
}
