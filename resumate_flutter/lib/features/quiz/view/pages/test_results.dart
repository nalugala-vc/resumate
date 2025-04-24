import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/quiz/view/widgets/bottom_section.dart';
import 'package:resumate_flutter/features/quiz/view/widgets/top_section.dart';

class TestResultsPage extends StatelessWidget {
  final Map<String, double> results;
  final String topCategory;
  final String level;
  final List<String> recommendations;
  final Map<String, String> categoryNames;
  final Function(String) calculateCategoryMetrics;

  const TestResultsPage({
    Key? key,
    required this.results,
    required this.topCategory,
    required this.level,
    required this.recommendations,
    required this.categoryNames,
    required this.calculateCategoryMetrics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppPallete.pink400,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            spaceH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TopSection(
                results: results,
                topCategory: topCategory,
                categoryNames: categoryNames,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(24),
                child: BottomSection(recommendations: recommendations),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
