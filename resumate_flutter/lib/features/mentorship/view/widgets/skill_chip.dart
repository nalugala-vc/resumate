import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class SkillChip extends StatelessWidget {
  final String label;

  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppPallete.primary100,
      ),
      child: SfProDisplay(
        text: label,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        textColor: AppPallete.primary400,
      ),
    );
  }
}
