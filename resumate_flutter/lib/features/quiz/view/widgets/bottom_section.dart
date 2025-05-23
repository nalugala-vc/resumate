import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/custom_nav_bar.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';

class BottomSection extends StatelessWidget {
  final List<String> recommendations;
  const BottomSection({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SfProDisplay(
          text: "Suggested Skills to Learn",
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        spaceH25,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              recommendations
                  .map(
                    (skill) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppPallete.primary100,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: SfProDisplay(
                        text: skill,
                        fontSize: 15,
                        textColor: AppPallete.primary400,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                  .toList(),
        ),
        const Spacer(),
        Center(
          child: RoundedButton(
            label: 'Go to feed',
            onTap: () {
              Get.to(() => CustomBottomNavBar());
            },
            height: 55,
            backgroundColor: AppPallete.pink400,
            fontsize: 15,
            borderRadius: 30,
            borderColor: AppPallete.pink400,
            width: 170,
          ),
        ),
        spaceH40,
      ],
    );
  }
}
