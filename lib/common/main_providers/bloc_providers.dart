import 'package:card_holder/common/configs/setting_config.dart';
import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/di_container/modules/di_module_helpers.dart';
import 'package:card_holder/common/di_container/modules/di_module_repository.dart';
import 'package:card_holder/common/di_container/modules/di_module_services.dart';
import 'package:card_holder/features/app/cubit/app_cubit.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class BlocProviders {
  const BlocProviders(this.diContainer, this.settingConfig);

  final DiContainerProvider diContainer;
  final SettingConfig settingConfig;

  DiModuleServices get services => diContainer.services;
  DiModuleRepository get repositories => diContainer.repositories;
  DiModuleHelpers get helpers => diContainer.helpers;

  List<BlocProvider> get list => [
    BlocProvider<SettingsBloc>(
      lazy: false,
      create:
          (_) => SettingsBloc(
            localStorage: services.localStorage,
            settingConfig: settingConfig,
            shareRepository: repositories.share,
          )..add(SettingInitEvent()),
    ),
    BlocProvider<CardsBloc>(
      lazy: false,
      create:
          (_) => CardsBloc(
            imageConvertHelper: helpers.converter,
            shareRepository: repositories.share,
            filePickRepository: repositories.filePick,
            cardRepo: repositories.card,
          )..add(CardsFetchCardsEvent()),
    ),
    BlocProvider<AppCubit>(
      lazy: false,
      create:
          (_) => AppCubit(
            convertHelper: helpers.converter,
            appLinkService: services.appLink,
          ),
    ),
  ];
}
