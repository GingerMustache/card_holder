import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rxdart/rxdart.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

mixin EventTransformerMixin {
  EventTransformer<BlocEventAbstract> debounceRestartable<BlocEventAbstract>() {
    return (events, mapper) => restartable<BlocEventAbstract>().call(
      events.debounceTime(const Duration(milliseconds: 300)),
      mapper,
    );
  }
}

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

      emit(state.copyWith(code: formattedCode));
    }
  }

  Future<void> _onAddName(
    CreateCardChangeNameEvent event,
    Emitter<CreateCardState> emit,
  ) async => emit(state.copyWith(name: event.name.replaceAll(' ', '')));

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
