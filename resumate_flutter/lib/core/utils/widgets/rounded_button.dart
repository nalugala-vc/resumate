import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final bool isLoading;
  final double height;
  final double fontsize;
  final double width;

  const RoundedButton({
    super.key,
    required this.label,
    this.height = 60,
    this.borderRadius = 7,
    this.fontsize = 20,
    this.width = double.maxFinite,
    this.textColor = AppPallete.whiteColor,
    this.backgroundColor = AppPallete.primary400,
    this.borderColor = AppPallete.primary400,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1.5),
        color: backgroundColor,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child:
            isLoading
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : SfProDisplay(
                  fontSize: fontsize,
                  text: label,
                  textColor: textColor,
                ),
      ),
    );
  }
}
