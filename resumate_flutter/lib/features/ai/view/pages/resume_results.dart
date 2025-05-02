import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/ai/model/ResumeResults.dart';
import 'package:resumate_flutter/features/ai/view/widgets/bottom_section_resume.dart';
import 'package:resumate_flutter/features/ai/view/widgets/top_section_resume.dart';

class ResumeResultsPage extends StatelessWidget {
  final ResumeResults results;

  const ResumeResultsPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppPallete.primary400,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            spaceH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TopSectionResume(overallResult: results.overallScore),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(24),
                child: BottomSectionResume(results: results),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
