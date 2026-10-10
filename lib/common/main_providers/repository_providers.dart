import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/di_container/modules/di_module_helpers.dart';
import 'package:card_holder/common/di_container/modules/di_module_services.dart';
import 'package:card_holder/common/helpers/converter/text_field_validator/text_field_validator.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show RepositoryProvider;

class RepositoryProviders {
  const RepositoryProviders(this.diContainer);

  final DiContainerProvider diContainer;

  DiModuleServices get services => diContainer.services;
  DiModuleHelpers get helpers => diContainer.helpers;

  List<RepositoryProvider<dynamic>> get list => [
    RepositoryProvider<BrightnessService>(
      lazy: false,
      create: (_) => services.brightness..getBrightness(),
    ),
    RepositoryProvider<TextValidatorService>(
      lazy: false,
      create: (_) => helpers.textValidator,
    ),
  ];
}
