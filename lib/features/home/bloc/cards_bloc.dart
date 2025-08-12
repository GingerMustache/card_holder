import 'package:bloc/bloc.dart';
import 'package:card_holder/common/services/local_crud/card_service.dart';
import 'package:equatable/equatable.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final CardServiceAbstract _cardService;
  CardsBloc({required CardServiceAbstract cardService})
    : _cardService = cardService,
      super(CardsState()) {
    on<CardsFetchCardsEvent>(_onFetchCards);
  }
  _onFetchCards(CardsFetchCardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final cards = await _cardService.getAllCards();

    emit(state.copyWith(cards: cards, isLoading: false));
  }
}
