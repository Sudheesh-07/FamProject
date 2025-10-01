import 'package:dartz/dartz.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';


/// Abstract repository interface
abstract class CardRepository {
  Future<Either<String, List<ApiResponse>>> fetchCards();
  Future<bool> dismissCard(int cardId);
  Future<bool> remindLaterCard(int cardId);
  List<int> getDismissedCardIds();
  List<int> getRemindedCardIds();
  Future<void> clearRemindedCards();
}
