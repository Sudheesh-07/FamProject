import 'package:hive/hive.dart';

part 'card_action_model.g.dart';

/// Model to store card actions (dismissed/reminded)
@HiveType(typeId: 0)
class CardActionModel extends HiveObject {

  /// Constructs a [CardActionModel] instance.
  CardActionModel({
    required this.cardId,
    required this.action,
    required this.timestamp,
  });
  @HiveField(0)
  /// ID of the card
  final int cardId;

  @HiveField(1)
  /// 'dismissed' or 'reminded'
  final String action; 

  @HiveField(2)
  ///
  final DateTime timestamp;
}
