import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class SfProDisplay extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double fontSize;
  final bool shouldTruncate;
  final FontWeight fontWeight;
  final int truncateLength;
  final TextAlign textAlignment;
  final double lineheight;
  final bool underline;

  SfProDisplay({
    super.key,
    required this.text,
    this.shouldTruncate = true,
    this.lineheight = 2,
    this.textColor = AppPallete.black,
    this.fontSize = 0,
    this.truncateLength = 45,

    this.fontWeight = FontWeight.bold,
    this.textAlignment = TextAlign.center,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor =
        textColor ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Text(
      shouldTruncate
          ? text.length > truncateLength
              ? '${text.substring(0, truncateLength)}...'
              : text
          : text,
      textAlign: textAlignment,
      style: TextStyle(
        color: effectiveTextColor,
        fontFamily: 'SFPRO',

        height: lineheight,
        fontSize: fontSize == 0 ? 36 : fontSize,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
