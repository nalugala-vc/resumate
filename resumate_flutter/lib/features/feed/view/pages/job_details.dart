import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:readmore/readmore.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 20),
                  NotificationsIcon(),
                ],
              ),

              spaceH20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SfProDisplay(
                          text: "Junior Product\nDesigner",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          textColor: AppPallete.black,
                          textAlignment: TextAlign.left,
                          lineheight: 0,
                        ),
                        spaceH10,
                        Wrap(
                          spacing: 8,
                          children: [
                            _tag("Full time"),
                            _tag("Remote"),
                            _tag("Contract"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              value: 0.75,
                              strokeWidth: 6,
                              backgroundColor: AppPallete.pink100,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppPallete.pink400,
                              ),
                            ),
                          ),
                          SfProDisplay(
                            text: "75%\nmatch",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            textColor: AppPallete.black,
                            textAlignment: TextAlign.center,
                            lineheight: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              spaceH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statBlock("Salary", "120K / yr"),
                  _statBlock("Applicants", "20"),
                  _statBlock("Expiry Date", "1st\nApril 2025"),
                ],
              ),
              spaceH15,
              SfProDisplay(
                text: "Description",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                textColor: AppPallete.black,
              ),

              spaceH10,
              const ReadMoreText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                trimLines: 4,
                trimMode: TrimMode.Line,
                trimCollapsedText: " Read More",
                trimExpandedText: " Show Less",
                style: TextStyle(
                  color: AppPallete.greyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  fontFamily: 'SFPRO',
                ),
                moreStyle: TextStyle(color: Colors.teal),
                lessStyle: TextStyle(color: Colors.teal),
              ),

              spaceH15,

              SfProDisplay(
                text: "Responsibilities",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                textColor: AppPallete.black,
              ),
              spaceH10,
              _responsibilityItem(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              ),
              _responsibilityItem(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              ),
              _responsibilityItem(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              ),
              _responsibilityItem(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              ),
              _responsibilityItem(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              ),

              spaceH50,
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: RoundedButton(label: 'Apply Now', onTap: () {}),
      ),
    );
  }

  // Tag widget
  Widget _tag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.teal,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Stat block
  static Widget _statBlock(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SfProDisplay(
          text: title,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          textColor: AppPallete.greyColor,

          lineheight: 0,
        ),
        spaceH5,
        SfProDisplay(
          text: value,
          fontSize: 15,
          fontWeight: FontWeight.w700,
          lineheight: 0,
          textAlignment: TextAlign.left,
          textColor: AppPallete.black,
        ),
      ],
    );
  }

  Widget _responsibilityItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🚀 ", style: TextStyle(fontSize: 14)),
          Expanded(
            child: SfProDisplay(
              text: text,
              fontSize: 15,
              textColor: AppPallete.greyColor,
              shouldTruncate: false,
              textAlignment: TextAlign.left,
              fontWeight: FontWeight.w400,
              lineheight: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
