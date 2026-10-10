import 'package:card_holder/common/helpers/converter/convert_helper.dart';
import 'package:card_holder/common/helpers/converter/text_field_validator/text_field_validator.dart';

abstract interface class DiModuleHelpers {
  ConvertHelper get converter;
  TextValidatorService get textValidator;
}

final class DiModuleHelpersImpl implements DiModuleHelpers {
  @override
  late final ConvertHelper converter = ConvertHelper();
  @override
  late final TextValidatorService textValidator = TextValidatorService();
}
