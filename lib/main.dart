// need to run dart run build_runner build
import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/brightness_controll/brightness_control_service.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider, RepositoryProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DiContainerProvider diContainer = DiContainer();
  final flutterI18nDelegate = await LocaleClass.initLocaleDelegate();
  final app = diContainer.makeApp(flutterI18nDelegate);

  runApp(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          RepositoryProvider<BrightnessService>(
            lazy: false,
            create: (_) => diContainer.makeBrightnessService(),
          ),
          BlocProvider(
            create:
                (context) =>
                    SettingsBloc(localStorage: diContainer.makeLocalStorage())
                      ..add(SettingInitEvent()),
            lazy: false,
          ),
          BlocProvider(
            lazy: false,
            create:
                (context) => CardsBloc(
                  imageConvertHelper: diContainer.makeImageConverterHelper(),
                  shareRepository: diContainer.makeShareRepository(),
                  cardRepo: diContainer.makeCardRepository(),
                )..add(CardsFetchCardsEvent()),
          ),
        ],
        child: app,
      ),
    ),
  );
}
