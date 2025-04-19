import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const RoundedButton({
    super.key,
    required this.label,
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
        color: AppPallete.primary400,
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
                : SfProDisplay(
                  fontSize: 20,
                  text: label,
                  textColor: AppPallete.whiteColor,
                ),
      ),
    );
  }
}
