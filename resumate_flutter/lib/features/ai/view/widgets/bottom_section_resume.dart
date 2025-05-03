import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/ai/model/ResumeResults.dart';
import 'package:resumate_flutter/features/ai/view/pages/resume_review.dart';

class BottomSectionResume extends StatelessWidget {
  final ResumeResults results;
  const BottomSectionResume({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SfProDisplay(
          text: "Your Scores",
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        spaceH25,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildScoreWidget(name: 'Structure', score: '${results.structure}'),
            _buildScoreWidget(
              name: 'Impact and Experience',
              score: '${results.impact}',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildScoreWidget(name: 'Language', score: '${results.structure}'),
            _buildScoreWidget(
              name: 'ATS',
              score: '${results.atsCompatibility}',
            ),
          ],
        ),
        spaceH50,
        Center(
          child: RoundedButton(
            label: 'see detailed analysis',
            onTap: () {
              Get.to(() => ResumeReviewPage(results: results));
            },
            height: 55,

            fontsize: 15,
            borderRadius: 30,

            width: 210,
          ),
        ),
        spaceH40,
      ],
    );
  }
}

Widget _buildScoreWidget({
  required String name,
  required String score,
  bool isleft = false,
}) {
  return Column(
    crossAxisAlignment:
        isleft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
    children: [
      SfProDisplay(
        text: name,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        textColor: AppPallete.greyColor,
      ),
      SfProDisplay(text: score, fontSize: 32, fontWeight: FontWeight.w700),
    ],
  );
}
