import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class QuickActions extends StatelessWidget {
  final HeroIcons icon;
  final VoidCallback onTap;
  final String name;
  const QuickActions({
    super.key,
    required this.icon,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppPallete.lightOrange100,
            child: HeroIcon(
              icon,
              style: HeroIconStyle.solid,
              color: AppPallete.lightOrange400,
              size: 28,
            ),
          ),
          SfProDisplay(
            text: name,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textColor: AppPallete.greyColor,
          ),
        ],
      ),
    );
  }
}
