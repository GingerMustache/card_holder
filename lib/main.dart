// need to run dart run build_runner build
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/di_container/di_container.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DiContainerProvider diContainer = DiContainer();
  final flutterI18nDelegate = await LocaleClass.initLocaleDelegate();
  final app = diContainer.makeApp(flutterI18nDelegate);

  runApp(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    SettingsBloc(localStorage: diContainer.makeLocalStorage())
                      ..add(SettingInitEvent()),
            lazy: false,
          ),
        ],
        child: app,
      ),
    ),
  );
}
