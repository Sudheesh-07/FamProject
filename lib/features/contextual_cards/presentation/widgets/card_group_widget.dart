import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:famproject/features/contextual_cards/presentation/cubits/card_cubits.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/card_types/hc1_card.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/card_types/hc3_card.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/card_types/hc5_card.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/card_types/hc6_card.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/card_types/hc9_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardGroupWidget extends StatelessWidget {
  final CardGroup cardGroup;

  const CardGroupWidget({super.key, required this.cardGroup});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CardsCubit>();
    final visibleCards = cubit.getVisibleCards(cardGroup);

    if (visibleCards.isEmpty) {
      return const SizedBox.shrink();
    }

    // HC9 special handling
    if (cardGroup.designType == 'HC9') {
      return _buildHC9Layout(visibleCards);
    }

    // Scrollable layout
    if (cardGroup.isScrollable) {
      return _buildScrollableLayout(visibleCards);
    }

    // Non-scrollable layout
    return _buildNonScrollableLayout(visibleCards);
  }

  Widget _buildScrollableLayout(List<CardModel> cards) => Container(
      height: cardGroup.height?.toDouble() ?? 200,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cards.length,
        itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(right: index < cards.length - 1 ? 12 : 0),
            child: _buildCard(cards[index]),
          ),
      ),
    );

  Widget _buildNonScrollableLayout(List<CardModel> cards) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: cards.map((card) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildCard(card),
            ),
          )).toList(),
      ),
    );

  Widget _buildHC9Layout(List<CardModel> cards) => Container(
      height: cardGroup.height?.toDouble() ?? 195,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cards.length,
        itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(right: index < cards.length - 1 ? 12 : 0),
            child: HC9DynamicWidth(
              card: cards[index],
              height: cardGroup.height?.toDouble() ?? 195,
            ),
          ),
      ),
    );

  Widget _buildCard(CardModel card) {
    switch (cardGroup.designType) {
      case 'HC1':
        return HC1SmallDisplay(card: card);
      case 'HC3':
        return HC3BigDisplay(card: card);
      case 'HC5':
        return HC5ImageCard(card: card);
      case 'HC6':
        return HC6SmallArrow(card: card);
      case 'HC9':
        return HC9DynamicWidth(
          card: card,
          height: cardGroup.height?.toDouble() ?? 195,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
