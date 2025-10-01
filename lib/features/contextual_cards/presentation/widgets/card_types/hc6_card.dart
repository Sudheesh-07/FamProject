import 'package:cached_network_image/cached_network_image.dart';
import 'package:famproject/core/utils/color_utils.dart';
import 'package:famproject/core/utils/deeplink_handler.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';

class HC6SmallArrow extends StatelessWidget {
  final CardModel card;

  const HC6SmallArrow({super.key, required this.card});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => DeeplinkHandler.handleUrl(card.url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: ColorUtils.parseColor(card.bgColor),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (card.icon != null)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: card.icon!.imageUrl != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              card.icon!.imageUrl!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              if (card.icon != null) const SizedBox(width: 12),
              Expanded(
                child: card.formattedTitle != null
                    ? FormattedTextWidget(formattedText: card.formattedTitle!)
                    : Text(
                        card.title ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
}
