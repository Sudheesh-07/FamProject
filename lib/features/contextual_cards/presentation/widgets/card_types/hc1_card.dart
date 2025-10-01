import 'package:cached_network_image/cached_network_image.dart';
import 'package:famproject/core/utils/color_utils.dart';
import 'package:famproject/core/utils/deeplink_handler.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HC1SmallDisplay extends StatelessWidget {
  final CardModel card;

  const HC1SmallDisplay({super.key, required this.card});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => DeeplinkHandler.handleUrl(card.url),
      child: Container(
        height: 64,
        width: 150,
        decoration: BoxDecoration(
          color: ColorUtils.parseColor(card.bgColor),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            if (card.icon != null)
              Container(
                width: 40,
                height: 40,
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
            if (card.icon != null) const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (card.formattedTitle != null)
                    FormattedTextWidget(formattedText: card.formattedTitle!)
                  else if (card.title != null)
                    Text(
                      card.title!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (card.formattedDescription != null ||
                      card.description != null)
                    const SizedBox(height: 4),
                  if (card.formattedDescription != null)
                    FormattedTextWidget(
                      formattedText: card.formattedDescription!,
                    )
                  else if (card.description != null)
                    Text(
                      card.description!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
