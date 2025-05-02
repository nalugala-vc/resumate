import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class TopSectionResume extends StatelessWidget {
  final int overallResult;
  const TopSectionResume({super.key, required this.overallResult});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceH40,
        SfProDisplay(
          text: "Almost there! Your Resume is",
          fontSize: 20,
          fontWeight: FontWeight.normal,

          textColor: AppPallete.whiteColor,
        ),
        spaceH30,
        SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  value: 0.75,

                  strokeWidth: 4,
                  backgroundColor: Colors.white.withOpacity(0.4),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppPallete.primary700,
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: Center(
                  child: SfProDisplay(
                    text: "$overallResult%",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    textColor: AppPallete.primary700,
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceH30,
        SfProDisplay(
          text: 'optimized for employers',
          textColor: AppPallete.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        spaceH50,
      ],
    );
  }
}
