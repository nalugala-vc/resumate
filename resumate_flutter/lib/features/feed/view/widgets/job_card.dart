import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/spacers/spacers.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String employeeCount;
  final String jobTitle;
  final String jobDescription;
  final double matchPercent;
  final String imageUrl;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.companyName,
    required this.employeeCount,
    required this.jobTitle,
    required this.jobDescription,
    required this.matchPercent,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            // Top Row: Logo + Company Info
            Row(
              children: [
                Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                    color: AppPallete.primary400,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: Colors.white,
                  ), // You can replace with logo image
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfProDisplay(
                      text: companyName,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      lineheight: 0,
                      textColor: AppPallete.black,
                    ),
                    SfProDisplay(
                      text: '$employeeCount employees',
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
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Job Title
            SfProDisplay(
              text: jobTitle,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              lineheight: 0,
              textColor: AppPallete.black,
            ),

            spaceH10,

            // Job Description
            SfProDisplay(
              text: jobDescription,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              lineheight: 0,
              shouldTruncate: false,
              textColor: AppPallete.greyColor,
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SfProDisplay(
                  text: '${(matchPercent * 100).toInt()}% match',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  lineheight: 0,

                  textColor: AppPallete.black,
                ),

                ElevatedButton(
                  onPressed: onTap,
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
