import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resumate_flutter/core/utils/constants.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/auth/view/sign_in.dart';
import 'package:resumate_flutter/features/auth/viewmodel/auth_controller.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  spaceH30,
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/female_avatar.png'),
                  ),
                  const SizedBox(height: 8),

                  Obx(() {
                    var user = controller.currentUser.value;

                    if (user == null) {
                      Get.to(() => SignIn());
                    }
                    return Column(
                      children: [
                        SfProDisplay(
                          text: user!.name,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          lineheight: 0,
                        ),

                        SfProDisplay(
                          text: user.email,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          textColor: AppPallete.greyColor,
                        ),
                        spaceH20,
                        SfProDisplay(
                          text: getTitleFromTrack(
                            user.quizResults!.topCategory,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          lineheight: 0,
                        ),
                      ],
                    );
                  }),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 22,
                        color: AppPallete.primary400,
                      ),
                      spaceW5,
                      SfProDisplay(
                        text: 'Nairobi, Kenya',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            spaceH70,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SfProDisplay(
                      text: 'Experience',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Row(
                      children: [
                        Chip(
                          label: SfProDisplay(
                            text: '2 years',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            lineheight: 0,
                            textColor: AppPallete.pink400,
                          ),
                          backgroundColor: AppPallete.pink100,
                          labelStyle: TextStyle(color: Colors.redAccent),
                        ),
                        SizedBox(width: 8),
                        Obx(() {
                          var user = controller.currentUser.value;
                          return Chip(
                            label: SfProDisplay(
                              text: user!.quizResults!.level,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              lineheight: 0,
                              textColor: AppPallete.primary400,
                            ),
                            backgroundColor: AppPallete.primary100,
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            spaceH12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SfProDisplay(
                      text: 'Education',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Row(
                      children: [
                        Chip(
                          label: SfProDisplay(
                            text: 'Bachelors',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            lineheight: 0,
                            textColor: AppPallete.primary400,
                          ),
                          backgroundColor: AppPallete.primary100,
                          labelStyle: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            spaceH12,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppPallete.primary400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfProDisplay(
                      text: 'Skills',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      textColor: AppPallete.whiteColor,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        SkillChip(label: 'HTML & CSS'),
                        SkillChip(label: 'JavaScript'),
                        SkillChip(label: 'JSON'),
                        SkillChip(label: 'Java'),
                        SkillChip(label: 'SQL'),
                        SkillChip(label: 'Node.js'),
                        SkillChip(label: 'React.js'),
                        SkillChip(label: 'TypeScript'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      // ignore: deprecated_member_use
      backgroundColor: AppPallete.primary400.withOpacity(0.7),
    );
  }
}
