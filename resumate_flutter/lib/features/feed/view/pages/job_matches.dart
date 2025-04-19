import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/spacers/spacers.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';
import 'package:resumate_flutter/features/feed/model/job.dart';
import 'package:resumate_flutter/features/feed/view/widgets/job_card.dart';
import 'package:resumate_flutter/features/feed/view/widgets/search_bar.dart';

class JobMatches extends StatelessWidget {
  const JobMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SfProDisplay(
                        text: 'Job Matches',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        textColor: AppPallete.black,
                        lineheight: 0,
                      ),
                      SfProDisplay(
                        text: 'Discover jobs that match your skills',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppPallete.greyColor,
                        lineheight: 0,
                      ),
                    ],
                  ),
                  Container(
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
                  ),
                ],
              ),
              spaceH30,
              SearchBarWidget(),
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
      ),
    );
  }
}
