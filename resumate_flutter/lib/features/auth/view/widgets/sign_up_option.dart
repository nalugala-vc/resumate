import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class SignUpOptions extends StatelessWidget {
  final String text;
  const SignUpOptions({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.0,
          child: Divider(thickness: 1.0, color: AppPallete.greyColor),
        ),
        spaceW10,
        SfProDisplay(
          text: text,
          fontSize: 18,
          fontWeight: FontWeight.normal,
          textColor: AppPallete.greyColor,
        ),
        spaceW10,
        SizedBox(
          width: 100.0,
          child: Divider(thickness: 1.0, color: AppPallete.greyColor),
        ),
      ],
    );
  }
}
