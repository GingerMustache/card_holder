import 'package:card_holder/common/helpers/converter/text_field_validator/text_field_validator.dart';
import 'package:card_holder/common/services/app_link/app_link_service.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:card_holder/common/services/error_service/error_service.dart';
import 'package:card_holder/common/services/file_pick/file_pick_service.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/common/services/local_storage/secure_storage.dart';
import 'package:card_holder/common/services/share/shared_service.dart';

abstract interface class DiModuleServices {
  BrightnessService get brightness;
  CardServiceAbstract get card;
  ShareService get share;
  FilePickService get filePick;
  LocalStorageService get localStorage;
  AppLinkService get appLink;
  MainErrorService get error;
}

final class DiModuleServicesImpl implements DiModuleServices {
  @override
  late final BrightnessService brightness = BrightnessServiceImpl();
  @override
  late final CardServiceAbstract card = LocalCardService();
  @override
  late final ShareService share = NetShareServiceImpl();
  @override
  late final FilePickService filePick = NetFilePickServiceImpl();
  @override
  late final LocalStorageService localStorage = SecureStorage();
  @override
  late final AppLinkService appLink = AppLinkService();
  @override
  MainErrorService get error => MainErrorService.instance;
}
