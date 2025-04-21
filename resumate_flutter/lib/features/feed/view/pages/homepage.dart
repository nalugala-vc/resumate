import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/feed/model/job.dart';
import 'package:resumate_flutter/features/feed/view/widgets/job_card.dart';
import 'package:resumate_flutter/features/feed/view/widgets/quick_actions.dart';
import 'package:resumate_flutter/features/feed/view/widgets/readiness_indicator.dart';
import 'package:resumate_flutter/features/feed/view/widgets/top_bar_user.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TopBarUser(name: 'Ms. Venessa'),
            spaceH10,
            ReadinessIndicator(),
            spaceH20,
            Align(
              alignment: Alignment.centerLeft,
              child: SfProDisplay(
                text: 'Quick Actions',
                textColor: AppPallete.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                textAlignment: TextAlign.left,
              ),
            ),
            spaceH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuickActions(
                  icon: HeroIcons.arrowUpTray,
                  name: 'Upload Resume',
                  onTap: () {},
                ),
                QuickActions(
                  icon: HeroIcons.lightBulb,
                  name: 'AI Career Quiz',
                  onTap: () {},
                ),
                QuickActions(
                  icon: HeroIcons.chatBubbleLeftRight,
                  name: 'Mock Interviews',
                  onTap: () {},
                ),
              ],
            ),

            spaceH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SfProDisplay(
                  text: 'Job Matches',
                  textColor: AppPallete.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  textAlignment: TextAlign.left,
                ),
                GestureDetector(
                  onTap: () {
                    print('Text tapped!');
                  },
                  child: Row(
                    children: [
                      SfProDisplay(
                        text: 'View All',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textColor: AppPallete.primary400,
                      ),
                      spaceW5,
                      const Icon(
                        Icons.arrow_right_rounded,
                        color: AppPallete.primary400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            spaceH20,
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: JobCard(
                      companyName: job.companyName,
                      employeeCount: job.employeeCount,
                      jobTitle: job.jobTitle,
                      jobDescription: job.jobDescription,
                      matchPercent: job.matchPercent,
                      imageUrl: job.imageUrl,
                      onTap: () {
                        // Handle tap here (navigate, show dialog, etc.)
                        print("Tapped ${job.jobTitle}");
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
