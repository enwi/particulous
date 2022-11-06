import 'package:flutter/material.dart';
import 'package:particulous/util/string_util.dart';

abstract class ColorUtil {
  /// Get the color for a given string [text].
  /// Optionally set the [saturation] ([0;1]) and [value] ([0;1])
  static Color colorFor(
    final String text, {
    final double saturation = 0.8,
    final double value = 0.8,
  }) {
    return HSVColor.fromAHSV(
            1.0, (StringUtil.hash(text) / 10.0) % 360.0, saturation, value)
        .toColor();
  }
}
