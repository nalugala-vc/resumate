import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/loader.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/features/feed/view/widgets/job_card.dart';
import 'package:resumate_flutter/features/feed/view/widgets/search_bar.dart';
import 'package:resumate_flutter/features/feed/viewmodel/feed_controller.dart';
import 'package:resumate_flutter/features/quiz/viewmodel/results_controller.dart';

class JobMatches extends StatelessWidget {
  const JobMatches({super.key});

  @override
  Widget build(BuildContext context) {
    final feedController = Get.find<FeedController>();
    final resultsController = Get.find<ResultsController>();
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
                  NotificationsIcon(),
                ],
              ),
              spaceH30,
              SearchBarWidget(hintText: 'Search jobs...'),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Obx(() {
                  if (feedController.isLoading.value) {
                    return const Loader(loaderColor: AppPallete.primary400);
                  }

                  final jobList = feedController.jobOpportunities;
                  final results = resultsController.results;

                  if (jobList.isEmpty) {
                    return const Center(child: Text("No jobs found"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: jobList.length,
                    itemBuilder: (context, index) {
                      final job = jobList[index];

                      final categoryKey = job.category.toLowerCase();
                      final matchScore = results[categoryKey] ?? 0.0;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: JobCard(
                          job: job,
                          matchPercent: matchScore.toDouble(),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
