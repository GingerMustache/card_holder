import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rxdart/rxdart.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  late final MobileScannerController cameraController;
  late final StreamSubscription cameraControllerSubscription;

  AddCardBloc() : super(AddCardState()) {
    on<AddCardChangeCodeEvent>(_onAddCode, transformer: _debounceRestartable());
    on<AddCardChangeNameEvent>(_onAddName, transformer: _debounceRestartable());
    on<AddCardSearchEvent>(_onSearch, transformer: _debounceRestartable());

    cameraController = MobileScannerController(detectionTimeoutMs: 1500);
    cameraControllerSubscription = cameraController.barcodes.listen(
      (event) => {},
    );
  }

  EventTransformer<CatalogEvent> _debounceRestartable<CatalogEvent>() {
    return (events, mapper) => restartable<CatalogEvent>().call(
      events.debounceTime(const Duration(milliseconds: 300)),
      mapper,
    );
  }

  Future<void> _onAddCode(
    AddCardChangeCodeEvent event,
    Emitter<AddCardState> emit,
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
    AddCardChangeNameEvent event,
    Emitter<AddCardState> emit,
  ) async => emit(state.copyWith(name: event.name.replaceAll(' ', '')));

  Future<void> _onSearch(
    AddCardSearchEvent event,
    Emitter<AddCardState> emit,
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
