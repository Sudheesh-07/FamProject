import 'dart:math' as math;

import 'package:flutter/material.dart';

class ColorUtils {
  static Color? parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    String hex = colorString.replaceAll('#', '');

    /// This is to handle rgb format as the api return in same format
    if (hex.length == 6) {
      return Color(int.parse('0xFF$hex'));
    }

    /// Just in case the api returns 8 digit hex code
    if (hex.length == 8) {
      return Color(int.parse('0x$hex'));
    }
    return null;
  }

  static LinearGradient createGradient(List<String> colors, double angle) {
    if (colors.isEmpty) {
      return const LinearGradient(
        colors: [Colors.transparent, Colors.transparent],
      );
    }

    final gradientColors = colors
        .map((c) => parseColor(c) ?? Colors.transparent)
        .toList();

    // Convert angle to alignment
    final alignment = _angleToAlignment(angle);

    return LinearGradient(
      begin: alignment.begin,
      end: alignment.end,
      colors: gradientColors,
    );
  }

  static _GradientAlignment _angleToAlignment(double angle) {
    // Normalize angle to 0-360
    final normalizedAngle = angle % 360;

    // Here I have converted CSS gradient angle to Flutter alignment
    // CSS: 0° is top, 90° is right, 180° is bottom, 270° is left

    final radians = (normalizedAngle - 90) * math.pi / 180;

    return _GradientAlignment(
      begin: Alignment(-math.cos(radians), -math.sin(radians)),
      end: Alignment(math.cos(radians), math.sin(radians)),
    );
  }
}

class _GradientAlignment {
  final Alignment begin;
  final Alignment end;

  _GradientAlignment({required this.begin, required this.end});
}
