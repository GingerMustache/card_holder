import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

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
    final code = int.tryParse(event.code);

    final formatter = NumberFormat('#,###', 'en'); // will use commas
    final formattedCode = formatter.format(code).replaceAll(',', ' ');

    emit(state.copyWith(code: formattedCode));
  }
}
