import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/back_button.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';

class AppBarWithNotificationIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showBackButton;
  final Color bgColor;

  const AppBarWithNotificationIcon({
    super.key,
    this.showBackButton = true,
    this.bgColor = AppPallete.whiteColor,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: buildBackButton(),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: NotificationsIcon(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
