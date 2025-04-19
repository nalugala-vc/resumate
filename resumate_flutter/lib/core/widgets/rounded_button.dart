import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  final bool isLoading;

  const RoundedButton({
    super.key,
    required this.label,
    this.textColor = AppPallete.whiteColor,
    this.backgroundColor = AppPallete.primary400,
    this.borderColor = AppPallete.primary400,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor, width: 1.5),
        color: backgroundColor,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
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
                : SfProDisplay(fontSize: 20, text: label, textColor: textColor),
      ),
    );
  }
}
