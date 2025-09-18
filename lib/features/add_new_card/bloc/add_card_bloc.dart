import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:card_holder/common/mixins/event_transformer_mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState>
    with EventTransformerMixin {
  late final MobileScannerController cameraController;
  late final StreamSubscription cameraControllerSubscription;

  CreateCardBloc() : super(CreateCardState()) {
    on<CreateCardChangeCodeEvent>(
      _onAddCode,
      transformer: debounceRestartable(),
    );
    on<CreateCardChangeNameEvent>(
      _onAddName,
      transformer: debounceRestartable(),
    );
    on<CreateCardSetInitColorEvent>(_onSetInitColor);
    on<CreateCardChangeColorEvent>(_onChangeColor);
    on<CreateCardChangeMarkTapEvent>(_onChangeMarkTap);
    on<CreateCardSearchEvent>(_onSearch, transformer: debounceRestartable());

    cameraController = MobileScannerController(detectionTimeoutMs: 1500);
    cameraControllerSubscription = cameraController.barcodes.listen(
      (event) => {},
    );
  }

  Future<void> _onAddCode(
    CreateCardChangeCodeEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    final onlyNumbers = event.code.replaceAll(RegExp(r'[^0-9]'), '');
    if (onlyNumbers.isEmpty) {
      emit(state.copyWith(code: ''));
    } else {
      final formatter = NumberFormat('#,###', 'en');
      final formattedCode = formatter
          .format(int.tryParse(onlyNumbers))
          .replaceAll(',', ' ');

      emit(state.copyWith(code: formattedCode, isMarkTapped: false));
    }
  }

  Future<void> _onChangeColor(
    CreateCardChangeColorEvent event,
    Emitter<CreateCardState> emit,
  ) async => emit(state.copyWith(color: event.color, isMarkTapped: false));

  Future<void> _onChangeMarkTap(
    CreateCardChangeMarkTapEvent event,
    Emitter<CreateCardState> emit,
  ) async => emit(state.copyWith(isMarkTapped: !state.isMarkTapped));

  Future<void> _onSetInitColor(
    CreateCardSetInitColorEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    final int randomColor = (Random().nextDouble() * 0xFFFFFF).toInt();

    emit(state.copyWith(color: randomColor));
  }

  Future<void> _onAddName(
    CreateCardChangeNameEvent event,
    Emitter<CreateCardState> emit,
  ) async => emit(
    state.copyWith(name: event.name.replaceAll(' ', ''), isMarkTapped: false),
  );

  Future<void> _onSearch(
    CreateCardSearchEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    final barcodes = event.barcodes;
    if (barcodes.barcodes.isNotEmpty &&
        barcodes.barcodes.first.rawValue != null) {
      await _submit();
      cameraControllerSubscription.pause();
    }
  }

  Future<bool> _submit() async {
    return true;
  }

  @override
  Future<void> close() {
    cameraControllerSubscription.cancel();
    cameraController.stop();
    cameraController.dispose();

    return super.close();
  }
}
