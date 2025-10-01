import 'package:famproject/core/utils/color_utils.dart';
import 'package:famproject/core/utils/deeplink_handler.dart';
import 'package:famproject/core/utils/text_style_utils.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FormattedTextWidget extends StatelessWidget {
  final FormattedText formattedText;
  final TextStyle? defaultTextStyle;

  const FormattedTextWidget({
    super.key,
    required this.formattedText,
    this.defaultTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        defaultTextStyle ?? const TextStyle(fontSize: 14, color: Colors.black);

    // Parse the template text and replace {} with entities
    final spans = _buildTextSpans(baseStyle);

    return RichText(
      text: TextSpan(children: spans),
      textAlign: _getTextAlign(),
    );
  }

  TextAlign _getTextAlign() {
    switch (formattedText.align?.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
      default:
        return TextAlign.left;
    }
  }

  List<InlineSpan> _buildTextSpans(TextStyle baseStyle) {
    final List<InlineSpan> spans = [];
    final template = formattedText.text;
    final entities = formattedText.entities;

    int entityIndex = 0;
    int currentIndex = 0;

    while (currentIndex < template.length) {
      final placeholderIndex = template.indexOf('{}', currentIndex);

      if (placeholderIndex == -1) {
        // No more placeholders, add remaining text
        final remainingText = template.substring(currentIndex);
        if (remainingText.isNotEmpty) {
          spans.add(TextSpan(text: remainingText, style: baseStyle));
        }
        break;
      }

      // Add text before placeholder
      if (placeholderIndex > currentIndex) {
        final textBeforePlaceholder = template.substring(
          currentIndex,
          placeholderIndex,
        );
        spans.add(TextSpan(text: textBeforePlaceholder, style: baseStyle));
      }

      // Add entity at placeholder position
      if (entityIndex < entities.length) {
        final entity = entities[entityIndex];
        spans.add(_buildEntitySpan(entity, baseStyle));
        entityIndex++;
      }

      currentIndex = placeholderIndex + 2; // Move past {}
    }

    return spans;
  }

  InlineSpan _buildEntitySpan(Entity entity, TextStyle baseStyle) {
    final entityColor = ColorUtils.parseColor(entity.color);
    final fontSize = entity.fontSize?.toDouble() ?? baseStyle.fontSize ?? 14;
    final fontWeight = TextStyleUtils.parseFontFamily(entity.fontFamily);

    TextStyle entityStyle = baseStyle.copyWith(
      color: entityColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

    entityStyle = TextStyleUtils.applyFontStyle(entityStyle, entity.fontStyle);

    // If entity has URL, make it tappable
    if (entity.url != null && entity.url!.isNotEmpty) {
      return TextSpan(
        text: entity.text,
        style: entityStyle.copyWith(decoration: TextDecoration.underline),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            DeeplinkHandler.handleUrl(entity.url);
          },
      );
    }

    return TextSpan(text: entity.text, style: entityStyle);
  }
}
