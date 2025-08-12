part of 'cards_bloc.dart';

final class CardsState extends Equatable {
  const CardsState({
    this.isLoading = false,
    this.cards = const [],
    this.currentCard,
  });

  final bool isLoading;
  final List<DataBaseCard> cards;
  final DataBaseCard? currentCard;

  CardsState copyWith({
    bool? isLoading,
    List<DataBaseCard>? cards,
    DataBaseCard? currentCard,
  }) {
    return CardsState(
      isLoading: isLoading ?? this.isLoading,
      cards: cards ?? this.cards,
      currentCard: currentCard ?? this.currentCard,
    );
  }

  @override
  List<Object?> get props => [cards, currentCard];
}
