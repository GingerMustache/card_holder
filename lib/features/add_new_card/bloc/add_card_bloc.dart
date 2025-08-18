import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  AddCardBloc() : super(AddCardState()) {
    on<AddCardChangeCodeEvent>(_onAddCode, transformer: _debounceRestartable());
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
    final formatter = NumberFormat('#,###', 'en'); // will use commas
    final formattedCode = formatter
        .format(int.parse(event.code))
        .replaceAll(',', ' ');

    emit(state.copyWith(code: formattedCode));
  }
}
