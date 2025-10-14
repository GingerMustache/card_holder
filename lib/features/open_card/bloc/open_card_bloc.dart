import 'package:bloc/bloc.dart';
import 'package:card_holder/common/mixins/event_transformer_mixin.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:equatable/equatable.dart';

part 'open_card_event.dart';
part 'open_card_state.dart';

class OpenCardBloc extends Bloc<OpenCardEvent, OpenCardState>
    with EventTransformerMixin {
  final BrightnessService _brightnessService;

  OpenCardBloc({required BrightnessService brightnessService})
    : _brightnessService = brightnessService,
      super(OpenCardState()) {
    on<OpenCardChangeCodeEvent>(_onAddCode, transformer: debounceRestartable());
    on<OpenCardChangeNameEvent>(_onAddName, transformer: debounceRestartable());
    on<OpenCardInitEvent>(_onSetCurrentCard);
    on<OpenCardChangeColorEvent>(_onChangeColor);
    on<OpenCardChangeMarkTapEvent>(_onChangeMarkTap);
    on<OpenCardChangeBrightnessEvent>(_onChangeBrightness);
  }

  Future<void> _onAddCode(
    OpenCardChangeCodeEvent event,
    Emitter<OpenCardState> emit,
  ) async {
    final onlyNumbers = event.code.replaceAll(RegExp(r'[^0-9]'), '');
    if (onlyNumbers.isEmpty) {
      emit(state.copyWith(code: ''));
    } else {
      final formattedCode = int.tryParse(onlyNumbers).toString();

      emit(state.copyWith(code: formattedCode, isMarkTapped: false));
    }
  }

  Future<void> _onSetCurrentCard(
    OpenCardInitEvent event,
    Emitter<OpenCardState> emit,
  ) async {
    final isAutoBrightness = event.brightnessMode == BrightnessMode.auto;
    if (isAutoBrightness) {
      _brightnessService.setMaxBrightness();
    }
    emit(
      state.copyWith(
        code: event.curCard.code,
        name: event.curCard.name,
        color: event.curCard.color,
        urlPath: event.curCard.urlPath,
        turnBrightnessOn: isAutoBrightness,
      ),
    );
  }

  Future<void> _onAddName(
    OpenCardChangeNameEvent event,
    Emitter<OpenCardState> emit,
  ) async => emit(
    state.copyWith(name: event.name.replaceAll(' ', ''), isMarkTapped: false),
  );

  Future<void> _onChangeColor(
    OpenCardChangeColorEvent event,
    Emitter<OpenCardState> emit,
  ) async => emit(state.copyWith(color: event.color));

  Future<void> _onChangeMarkTap(
    OpenCardChangeMarkTapEvent event,
    Emitter<OpenCardState> emit,
  ) async => emit(state.copyWith(isMarkTapped: !state.isMarkTapped));

  Future<void> _onChangeBrightness(
    OpenCardChangeBrightnessEvent event,
    Emitter<OpenCardState> emit,
  ) async {
    if (state.turnBrightnessOn || event.dismissSheet) {
      _brightnessService.setDefaultSystemBrightness();
    } else {
      _brightnessService.setMaxBrightness();
    }
    emit(state.copyWith(turnBrightnessOn: !state.turnBrightnessOn));
  }
}
