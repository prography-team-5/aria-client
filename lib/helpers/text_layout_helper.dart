import 'package:flutter/material.dart';

class TextLayoutHelper {
  TextLayoutHelper._();

  //특정 텍스트의 크기 구하기
  static Size getTextSize({
    required String text,
    required TextStyle style,
    int? maxLines,
    TextDirection? textDirection,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines ?? 1,
      textDirection: textDirection ?? TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}