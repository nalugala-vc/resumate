import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

Widget buildBackButton() {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: HeroIcon(
      HeroIcons.chevronLeft,
      style: HeroIconStyle.outline,
      color: Colors.black,
      size: 28,
    ),
  );
}
