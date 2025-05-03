import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/feed/viewmodel/feed_controller.dart';
import 'package:resumate_flutter/features/quiz/model/category_metric.dart';
import 'package:resumate_flutter/features/quiz/viewmodel/results_controller.dart';

class ReadinessIndicator extends StatefulWidget {
  const ReadinessIndicator({super.key});

  @override
  _ReadinessIndicatorState createState() => _ReadinessIndicatorState();
}

class _ReadinessIndicatorState extends State<ReadinessIndicator> {
  final resultsController = Get.find<ResultsController>();
  final feedController = Get.find<FeedController>();
  String selectedTrack = '';

  @override
  void initState() {
    super.initState();
    final results = resultsController.results;
    if (results.isNotEmpty) {
      final sorted =
          results.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      selectedTrack = _formatTrackName(sorted.first.key);

      feedController.selectedTrack.value = sorted.first.key;
    }
  }

  String _formatTrackName(String key) {
    switch (key) {
      case 'frontend':
        return 'Frontend Developer';
      case 'backend':
        return 'Backend Developer';
      case 'ml':
        return 'ML Engineer';
      default:
        return key;
    }
  }

  String _unformatTrackName(String name) {
    switch (name) {
      case 'Frontend Developer':
        return 'frontend';
      case 'Backend Developer':
        return 'backend';
      case 'ML Engineer':
        return 'ml';
      default:
        return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = resultsController.results;
    final sortedResults =
        results.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    final selectedKey = _unformatTrackName(selectedTrack);
    final double percentage = results[selectedKey] ?? 0;
    final List<CategoryMetric> metrics = resultsController
        .calculateCategoryMetrics(selectedKey);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SfProDisplay(
                text: selectedTrack,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                textColor: AppPallete.black,
                lineheight: 0,
              ),
              SfProDisplay(
                text: 'You are ${percentage.toStringAsFixed(0)}% ready',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppPallete.greyColor,
                lineheight: 0,
              ),
            ],
          ),
        ),
        spaceH30,
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 20,
                backgroundColor: AppPallete.primary100,
                color: AppPallete.primary400,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SfProDisplay(
                  text: '${percentage.toStringAsFixed(0)}%',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  textColor: AppPallete.black,
                  lineheight: 0,
                ),
                SfProDisplay(
                  text: 'Ready',
                  fontSize: 16,
                  lineheight: 0,
                  fontWeight: FontWeight.w400,
                  textColor: AppPallete.greyColor,
                ),
              ],
            ),
            Positioned(
              top: 20,
              right: -100,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppPallete.primary100,
                  border: Border.all(color: AppPallete.primary400),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedTrack,
                    isDense: true,
                    isExpanded: false,
                    style: const TextStyle(fontSize: 14),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.arrow_drop_down),
                    items:
                        sortedResults.map((entry) {
                          final name = _formatTrackName(entry.key);
                          return DropdownMenuItem(
                            value: name,
                            child: SfProDisplay(
                              text: name,
                              textColor: Colors.black,
                              fontSize: 14,
                              lineheight: 0,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTrack = value!;
                        final unformatted = _unformatTrackName(value);
                        feedController.selectedTrack.value = unformatted;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        spaceH30,
        Align(
          alignment: Alignment.centerLeft,
          child: SfProDisplay(
            text: 'Key Career Aspects',
            textColor: AppPallete.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            textAlignment: TextAlign.left,
          ),
        ),
        ...metrics.map((metric) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SfProDisplay(
                      text: metric.name,
                      fontSize: 15,
                      textColor: AppPallete.pink400,
                    ),
                    SfProDisplay(
                      text: '${metric.score.toStringAsFixed(0)}%',
                      fontSize: 15,
                      textColor: AppPallete.pink400,
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: metric.score / 100,
                  backgroundColor: AppPallete.pink100,
                  color: AppPallete.pink400,
                  minHeight: 10,
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
