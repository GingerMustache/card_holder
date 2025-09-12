import 'package:bloc/bloc.dart';
import 'package:card_holder/common/mixins/event_transformer_mixin.dart';
import 'package:card_holder/features/add_new_card/bloc/create_card_bloc.dart';
import 'package:equatable/equatable.dart';

part 'open_card_event.dart';
part 'open_card_state.dart';

class OpenCardBloc extends Bloc<OpenCardEvent, OpenCardState>
    with EventTransformerMixin {
  OpenCardBloc() : super(OpenCardInitial()) {
    on<OpenCardChangeCodeEvent>(_onAddCode, transformer: debounceRestartable());
    on<OpenCardChangeNameEvent>(_onAddName, transformer: debounceRestartable());
    on<OpenCardChangeColorEvent>(_onChangeColor);
    on<OpenCardChangeMarkTapEvent>(_onChangeMarkTap);
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

      emit(state.copyWith(code: formattedCode));
    }
  }

  Future<void> _onAddName(
    OpenCardChangeNameEvent event,
    Emitter<OpenCardState> emit,
  ) async => emit(state.copyWith(name: event.name.replaceAll(' ', '')));

  Future<void> _onChangeColor(
    OpenCardChangeColorEvent event,
    Emitter<OpenCardState> emit,
  ) async => emit(state.copyWith(color: event.color));

  Future<void> _onChangeMarkTap(
    OpenCardChangeMarkTapEvent event,
    Emitter<OpenCardState> emit,
  ) async => emit(state.copyWith(isMarkTapped: !state.isMarkTapped));
}
