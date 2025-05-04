import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

Widget buildBackButton({Color arrowColor = AppPallete.black}) {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: HeroIcon(
      HeroIcons.chevronLeft,
      style: HeroIconStyle.outline,
      color: arrowColor,
      size: 28,
    ),
  );
}
