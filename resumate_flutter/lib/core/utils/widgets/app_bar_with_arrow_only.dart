import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/back_button.dart';

class AppBarWithArrowOnly extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showBackButton;
  final Color bgColor;
  final Color arrowColor;

  const AppBarWithArrowOnly({
    super.key,
    this.showBackButton = true,
    this.bgColor = AppPallete.whiteColor,
    this.arrowColor = AppPallete.black,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: buildBackButton(arrowColor: arrowColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
