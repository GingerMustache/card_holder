part of 'cards_bloc.dart';

final class CardsState extends Equatable {
  const CardsState({this.isLoading = false, this.cards = const []});

  final bool isLoading;
  final List<DataBaseCard> cards;

  CardsState copyWith({bool? isLoading, List<DataBaseCard>? cards}) {
    return CardsState(
      isLoading: isLoading ?? this.isLoading,
      cards: cards ?? this.cards,
    );
  }

  @override
  List<Object> get props => [cards];
}
