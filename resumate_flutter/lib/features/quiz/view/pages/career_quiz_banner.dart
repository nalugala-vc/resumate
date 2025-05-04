import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/app_bar_with_notification_icon.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/quiz/view/pages/quiz_page.dart';

class CareerQuizBanner extends StatelessWidget {
  final bool showAppBar;
  const CareerQuizBanner({super.key, required this.showAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBarWithNotificationIcon() : null,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 👈 ensures vertical centering
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/career_quiz.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                spaceH10,
                SfProDisplay(
                  text: 'CAREER QuiZ',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
                SfProDisplay(
                  text:
                      'Discover your ideal career! Take our quick quiz to match with jobs that fit your skills and passions.',
                  fontSize: 16,
                  shouldTruncate: false,
                  fontWeight: FontWeight.w400,
                  textColor: AppPallete.greyColor,
                ),
                spaceH70,
                RoundedButton(
                  backgroundColor: AppPallete.pink400,
                  borderColor: AppPallete.pink400,
                  label: 'Take Quiz',
                  onTap: () {
                    Get.to(() => QuizPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
