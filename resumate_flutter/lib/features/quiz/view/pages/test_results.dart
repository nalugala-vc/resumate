import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/quiz/view/widgets/bottom_section.dart';
import 'package:resumate_flutter/features/quiz/view/widgets/top_section.dart';

class TestResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        backgroundColor: AppPallete.pink400,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              spaceH20,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TopSection(),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const BottomSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
