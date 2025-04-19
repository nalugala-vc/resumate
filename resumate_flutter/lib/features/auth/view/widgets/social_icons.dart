import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class SocialIcons extends StatelessWidget {
  final VoidCallback onTap;
  final String socialLogo;
  final double logoheight;
  final double logowidth;
  const SocialIcons({
    super.key,
    required this.onTap,
    required this.socialLogo,
    required this.logoheight,
    required this.logowidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: AppPallete.primary200,
          borderRadius: BorderRadius.circular(47),
        ),
        child: Center(
          child: Container(
            height: logoheight,
            width: logoheight,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(socialLogo),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
