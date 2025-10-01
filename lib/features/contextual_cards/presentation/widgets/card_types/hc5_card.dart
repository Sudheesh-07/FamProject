import 'package:cached_network_image/cached_network_image.dart';
import 'package:famproject/core/utils/color_utils.dart';
import 'package:famproject/core/utils/deeplink_handler.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:flutter/material.dart';

class HC5ImageCard extends StatelessWidget {
  final CardModel card;

  const HC5ImageCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => DeeplinkHandler.handleUrl(card.url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: card.bgImage?.imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: card.bgImage!.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                )
              : Container(
                  height: 200,
                  color: ColorUtils.parseColor(card.bgColor),
                ),
        ),
      ),
    );
}
