import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/mixins/event_transformer_mixin.dart';
import 'package:card_holder/features/add_new_card/presentation/template_card_sheet/template_card_sheet.dart';
import 'package:equatable/equatable.dart';
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
    on<CreateCardInitEvent>(_onInit);
    on<CreateCardSetInitTemplateEvent>(_onSetInitTemplate);
    on<CreateCardChangeColorEvent>(_onChangeColor);
    on<CreateCardChangeMarkTapEvent>(_onChangeMarkTap);
    on<CreateCardSearchEvent>(_onSearch, transformer: debounceRestartable());
    on<CreateCardResumeCameraEvent>(_onResumeCamera);
    on<CreateCardSearchTemplateEvent>(
      _onTemplateCardSearch,
      transformer: debounceRestartable(),
    );

    cameraController = MobileScannerController(detectionTimeoutMs: 1500);
    cameraControllerSubscription = cameraController.barcodes.listen(
      (event) => {},
    );
  }

  Future<void> _onInit(
    CreateCardInitEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    emit(state.copyWith(templates: event.templates));
  }

  Future<void> _onAddCode(
    CreateCardChangeCodeEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    final onlyNumbers = event.code.replaceAll(RegExp(r'[^0-9]'), '');
    if (onlyNumbers.isEmpty) {
      emit(state.copyWith(code: ''));
    } else {
      emit(
        state.copyWith(code: onlyNumbers.formatWithSpaces, isMarkTapped: false),
      );
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

  Future<void> _onSetInitTemplate(
    CreateCardSetInitTemplateEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    if (event.cardColor == null) {
      final int randomColor = (Random().nextDouble() * 0xFFFFFF).toInt();
      emit(state.copyWith(color: randomColor));
      return;
    } else {
      emit(
        state.copyWith(
          color: event.cardColor,
          name: event.cardName,
          urlPath: event.svgUrl,
          logoSize: event.logoSize,
        ),
      );
    }
    event.completer?.complete();
  }

  Future<void> _onAddName(
    CreateCardChangeNameEvent event,
    Emitter<CreateCardState> emit,
  ) async => emit(state.copyWith(name: event.name, isMarkTapped: false));

  Future<void> _onSearch(
    CreateCardSearchEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    final barcodes = event.barcodes;
    if (barcodes.barcodes.isNotEmpty &&
        barcodes.barcodes.first.rawValue != null) {
      cameraControllerSubscription.pause();

      final String detectedCode =
          barcodes.barcodes.first.rawValue!.formatWithSpaces;

      emit(state.copyWith(detectedCode: detectedCode, code: detectedCode));
    }
  }

  Future<void> _onResumeCamera(
    CreateCardResumeCameraEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    cameraControllerSubscription.resume();
    cameraController.start();

    emit(state.copyWith(code: '', detectedCode: ''));
  }

  _onTemplateCardSearch(
    CreateCardSearchTemplateEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    List<ShopTemplate> templates = state.templates;

    if (event.text != null && event.text!.isNotEmpty) {
      final List<ShopTemplate> foundCards =
          templates
              .where(
                (element) => element.name.toUpperCase().contains(
                  event.text?.toUpperCase() ?? '',
                ),
              )
              .toList();

      foundCards.isEmpty
          ? emit(
            state.copyWith(templates: state.templates, searchTemplates: []),
          )
          : emit(state.copyWith(searchTemplates: foundCards));
    } else {
      emit(state.copyWith(templates: state.templates, searchTemplates: []));
    }
  }

  @override
  Future<void> close() {
    cameraControllerSubscription.cancel();
    cameraController.stop();
    cameraController.dispose();

    return super.close();
  }
}
