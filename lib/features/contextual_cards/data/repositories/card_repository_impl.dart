import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:famproject/features/contextual_cards/data/models/card_action_model.dart';
import 'package:famproject/features/contextual_cards/domain/repositories/card_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CardRepositoryImpl implements CardRepository {
  final String apiUrl = dotenv.env['API_URL'] ?? '';

  late Box<CardActionModel> _cardActionsBox;

  CardRepositoryImpl() {
    _cardActionsBox = Hive.box<CardActionModel>('card_actions');
  }

  @override
  Future<Either<String, List<ApiResponse>>> fetchCards() async {
    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(response.body) as List<dynamic>;
        final List<ApiResponse> apiResponses = jsonData
            .map((json) => ApiResponse.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(apiResponses);
      } else {
        return Left('Failed to load cards: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Network error: $e');
    }
  }

  @override
  Future<bool> dismissCard(int cardId) async {
    try {
      final CardActionModel action = CardActionModel(
        cardId: cardId,
        action: 'dismissed',
        timestamp: DateTime.now(),
      );
      await _cardActionsBox.put('dismiss_$cardId', action);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> remindLaterCard(int cardId) async {
    try {
      final CardActionModel action = CardActionModel(
        cardId: cardId,
        action: 'reminded',
        timestamp: DateTime.now(),
      );
      await _cardActionsBox.put('remind_$cardId', action);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<int> getDismissedCardIds() => _cardActionsBox.values
      .where((CardActionModel action) => action.action == 'dismissed')
      .map((CardActionModel action) => action.cardId)
      .toList();

  @override
  List<int> getRemindedCardIds() => _cardActionsBox.values
      .where((CardActionModel action) => action.action == 'reminded')
      .map((CardActionModel action) => action.cardId)
      .toList();

  @override
  Future<void> clearRemindedCards() async {
    final List<String> remindedKeys = _cardActionsBox.values
        .where((CardActionModel action) => action.action == 'reminded')
        .map((CardActionModel action) => 'remind_${action.cardId}')
        .toList();

    for (final String key in remindedKeys) {
      await _cardActionsBox.delete(key);
    }
  }
}
