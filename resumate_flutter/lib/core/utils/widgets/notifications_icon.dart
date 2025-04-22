import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class NotificationsIcon extends StatelessWidget {
  const NotificationsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
