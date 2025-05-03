import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';

class BotMessage extends StatelessWidget {
  final String message;
  const BotMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(0),
          ),
        ),
        child: SfProDisplay(
          text: message,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          shouldTruncate: false,

          textAlignment: TextAlign.left,
        ),
      ),
    );
  }
}
