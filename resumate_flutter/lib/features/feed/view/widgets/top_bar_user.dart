import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';

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
        NotificationsIcon(),
      ],
    );
  }
}
