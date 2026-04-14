import 'package:bloc/bloc.dart';
import 'package:card_holder/common/services/app_link/app_link_service.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppLinkService _appLinkService;

  AppCubit({required AppLinkService appLinkService})
    : _appLinkService = appLinkService,
      super(AppState()) {
    _initLinks();
  }

  void _initLinks() {
    _appLinkService.appLinks.uriLinkStream.listen((uri) {
      emit(state.copyWith(uriLink: uri));
    });
  }
}
