import 'package:flutter/material.dart';

class TextStyleUtils {
  static TextStyle applyFontStyle(TextStyle baseStyle, String? fontStyle) {
    if (fontStyle == null) return baseStyle;

    TextStyle modifiedStyle = baseStyle;

    if (fontStyle.contains('underline')) {
      modifiedStyle = modifiedStyle.copyWith(
        decoration: TextDecoration.underline,
      );
    }

    if (fontStyle.contains('italic')) {
      modifiedStyle = modifiedStyle.copyWith(fontStyle: FontStyle.italic);
    }

    if (fontStyle.contains('bold')) {
      modifiedStyle = modifiedStyle.copyWith(fontWeight: FontWeight.bold);
    }

    return modifiedStyle;
  }

  static FontWeight parseFontFamily(String? fontFamily) {
    if (fontFamily == null) return FontWeight.normal;

    if (fontFamily.contains('bold')) {
      return FontWeight.bold;
    } else if (fontFamily.contains('semi_bold')) {
      return FontWeight.w600;
    } else if (fontFamily.contains('medium')) {
      return FontWeight.w500;
    }

    return FontWeight.normal;
  }
}
