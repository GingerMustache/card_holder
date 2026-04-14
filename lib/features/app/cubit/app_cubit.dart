import 'package:bloc/bloc.dart';
import 'package:card_holder/common/exceptions/image_helper_exceptions.dart';
import 'package:card_holder/common/helpers/converter/convert_helper.dart';
import 'package:card_holder/common/services/app_link/app_link_service.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppLinkService _appLinkService;
  final ConvertHelper _convertHelper;

  AppCubit({
    required AppLinkService appLinkService,
    required ConvertHelper convertHelper,
  }) : _appLinkService = appLinkService,
       _convertHelper = convertHelper,
       super(AppState()) {
    _initLinks();
  }

  void _initLinks() async {
    _appLinkService.appLinks.uriLinkStream.listen((uri) async {
      final jsonResult = await _convertHelper.jsonFromFile(filePath: uri.path);
      jsonResult.fold(
        (Exception e) {
          if (e is JsonFromFileFailed) {}
        },
        // right
        (Map<String, dynamic> cardMap) {
          emit(state.copyWith(jsonData: cardMap));
        },
      );
    });
  }
}
