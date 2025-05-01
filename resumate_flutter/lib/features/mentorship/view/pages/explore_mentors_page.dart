import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/loader.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/features/feed/view/widgets/search_bar.dart';
import 'package:resumate_flutter/features/mentorship/view/widgets/mentor_card.dart';
import 'package:resumate_flutter/features/mentorship/viewmodel/mentorship_controller.dart';

class ExploreMentorsPage extends StatefulWidget {
  const ExploreMentorsPage({super.key});

  @override
  State<ExploreMentorsPage> createState() => _ExploreMentorsPageState();
}

class _ExploreMentorsPageState extends State<ExploreMentorsPage> {
  final controller = Get.put(MentorshipController());

  @override
  void initState() {
    super.initState();
    controller.fetchMentors();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfProDisplay(
                      text: 'Explore Mentors',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
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
            spaceH20,
            SearchBarWidget(hintText: 'Search Mentor...'),
            spaceH20,

            Expanded(
              child: Obx(() {
                if (controller.mentors.isEmpty) {
                  return Loader(loaderColor: AppPallete.primary400);
                }

                return GridView.builder(
                  itemCount: controller.mentors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final mentor = controller.mentors[index];
                    return MentorCard(mentor: mentor);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
