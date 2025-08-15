import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  AddCardBloc() : super(AddCardState()) {
    on<AddCardChangeCodeEvent>(_onAddCode);
  }

  Future<void> _onAddCode(
    AddCardChangeCodeEvent event,
    Emitter<AddCardState> emit,
  ) async {
    emit(state.copyWith(code: event.code));
  }
}
