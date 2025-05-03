import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class UserMessage extends StatelessWidget {
  final String message;
  const UserMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppPallete.primary400,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(0), // no radius here
          ),
        ),

        child: SfProDisplay(
          text: message,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          shouldTruncate: false,
          textColor: AppPallete.whiteColor,

          textAlignment: TextAlign.left,
        ),
      ),
    );
  }
}
