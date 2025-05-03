import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/feed/model/JobOpportunities.dart';
import 'package:resumate_flutter/features/feed/view/pages/job_details.dart';

class JobCard extends StatelessWidget {
  final JobOpportunity job;
  final double matchPercent;

  const JobCard({super.key, required this.job, required this.matchPercent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => JobDetailsPage(job: job, matchPercent: matchPercent));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 115, 115, 115).withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                    color: AppPallete.primary400,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.business, color: Colors.white),
                ),
                spaceW12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfProDisplay(
                      text: job.company.name,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      lineheight: 0,
                      textColor: AppPallete.black,
                    ),
                    SfProDisplay(
                      text: '${job.company.numberOfEmployees} employees',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      lineheight: 0,
                      textColor: AppPallete.greyColor,
                    ),
                  ],
                ),
              ],
            ),
            spaceH15,
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                job.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            spaceH15,

            // Job Title
            SfProDisplay(
              text: job.title,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              lineheight: 0,
              textColor: AppPallete.black,
            ),

            spaceH10,

            // Job Description
            SfProDisplay(
              text: job.description,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              lineheight: 0,
              textAlignment: TextAlign.justify,
              truncateLength: 90,
              textColor: AppPallete.greyColor,
            ),

            spaceH15,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SfProDisplay(
                  text: '${matchPercent.toStringAsFixed(0)}% match',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  lineheight: 0,

                  textColor: AppPallete.black,
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () =>
                          JobDetailsPage(job: job, matchPercent: matchPercent),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.primary400,
                    minimumSize: const Size(120, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SfProDisplay(
                    text: 'Apply',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    lineheight: 0,
                    textColor: AppPallete.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
