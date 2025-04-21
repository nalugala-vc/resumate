import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class TopBarUser extends StatelessWidget {
  final String name;
  const TopBarUser({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              foregroundImage: AssetImage('assets/female_avatar.png'),
            ),
            spaceW10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SfProDisplay(
                  text: 'Hello 👋',
                  textColor: AppPallete.greyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  lineheight: 0,
                ),
                SfProDisplay(
                  text: name,
                  lineheight: 0,
                  textColor: AppPallete.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Center(
            child: HeroIcon(
              HeroIcons.bell,
              style: HeroIconStyle.outline,
              color: Colors.black,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
