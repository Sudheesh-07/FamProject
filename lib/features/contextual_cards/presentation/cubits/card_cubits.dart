import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:famproject/features/contextual_cards/domain/repositories/card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// States
abstract class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object?> get props => <Object?>[];
}

class CardsInitial extends CardsState {}

class CardsLoading extends CardsState {}

class CardsLoaded extends CardsState {

  const CardsLoaded({
    required this.cardGroups,
    this.dismissedCardIds = const <int>[],
    this.remindedCardIds = const <int>[],
  });
  final List<CardGroup> cardGroups;
  final List<int> dismissedCardIds;
  final List<int> remindedCardIds;

  @override
  List<Object?> get props => <Object?>[cardGroups, dismissedCardIds, remindedCardIds];

  CardsLoaded copyWith({
    List<CardGroup>? cardGroups,
    List<int>? dismissedCardIds,
    List<int>? remindedCardIds,
  }) => CardsLoaded(
      cardGroups: cardGroups ?? this.cardGroups,
      dismissedCardIds: dismissedCardIds ?? this.dismissedCardIds,
      remindedCardIds: remindedCardIds ?? this.remindedCardIds,
    );
}

class CardsError extends CardsState {

  const CardsError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

// Cubit
class CardsCubit extends Cubit<CardsState> {

  CardsCubit(this.repository) : super(CardsInitial());
  final CardRepository repository;

  Future<void> loadCards() async {
    emit(CardsLoading());

    final Either<String, List<ApiResponse>> result = await repository.fetchCards();

    result.fold((String error) => emit(CardsError(error)), (List<ApiResponse> responses) {
      if (responses.isEmpty) {
        emit(const CardsError('No data available'));
        return;
      }

      final List<int> dismissedIds = repository.getDismissedCardIds();
      final List<int> remindedIds = repository.getRemindedCardIds();

      // Flatten all card groups from all responses
      final List<CardGroup> allCardGroups = responses
          .expand((ApiResponse response) => response.hcGroups)
          .toList();

      emit(
        CardsLoaded(
          cardGroups: allCardGroups,
          dismissedCardIds: dismissedIds,
          remindedCardIds: remindedIds,
        ),
      );
    });
  }

  Future<void> refreshCards() async {
    // Clear reminded cards on app restart
    await repository.clearRemindedCards();
    await loadCards();
  }

  Future<void> dismissCard(int cardId) async {
    final CardsState currentState = state;
    if (currentState is! CardsLoaded) return;

    await repository.dismissCard(cardId);

    final List<int> updatedDismissedIds = <int>[...currentState.dismissedCardIds, cardId];

    emit(currentState.copyWith(dismissedCardIds: updatedDismissedIds));
  }

  Future<void> remindLater(int cardId) async {
    final CardsState currentState = state;
    if (currentState is! CardsLoaded) return;

    await repository.remindLaterCard(cardId);

    final List<int> updatedRemindedIds = <int>[...currentState.remindedCardIds, cardId];

    emit(currentState.copyWith(remindedCardIds: updatedRemindedIds));
  }

  List<CardModel> getVisibleCards(CardGroup group) {
    final CardsState currentState = state;
    if (currentState is! CardsLoaded) return group.cards;

    return group.cards.where((CardModel card) {
      // Only apply filtering for HC3 (Big Display Card)
      if (group.designType == 'HC3') {
        return !currentState.dismissedCardIds.contains(card.id) &&
            !currentState.remindedCardIds.contains(card.id);
      }
      return true;
    }).toList();
  }
}
