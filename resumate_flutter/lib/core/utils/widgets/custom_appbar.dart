import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/back_button.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 72 : 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,

      elevation: 0,

      title: Row(
        children: [
          showBackButton ? buildBackButton() : SizedBox(),
          spaceW10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SfProDisplay(
                text: title,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                textColor: AppPallete.black,
              ),
              SfProDisplay(
                text: subtitle!,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppPallete.greyColor,
                shouldTruncate: false,
                lineheight: 0,
              ),
              spaceH10,
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: NotificationsIcon(),
        ),
      ],
    );
  }
}
