import 'package:cached_network_image/cached_network_image.dart';
import 'package:famproject/core/utils/color_utils.dart';
import 'package:famproject/core/utils/deeplink_handler.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:flutter/material.dart';

class HC9DynamicWidth extends StatelessWidget {
  final CardModel card;
  final double height;

  const HC9DynamicWidth({super.key, required this.card, required this.height});

  @override
  Widget build(BuildContext context) {
    final aspectRatio = card.bgImage?.aspectRatio ?? 1.0;
    final width = height * aspectRatio;

    return GestureDetector(
      onTap: () => DeeplinkHandler.handleUrl(card.url),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: card.bgGradient != null
              ? ColorUtils.createGradient(
                  card.bgGradient!.colors,
                  card.bgGradient!.angle.toDouble(),
                )
              : null,
          color: card.bgGradient == null
              ? ColorUtils.parseColor(card.bgColor)
              : null,
        ),
        child: card.bgImage?.imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: card.bgImage!.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : null,
      ),
    );
  }
}
