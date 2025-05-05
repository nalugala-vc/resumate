import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/quiz/model/question.dart';
import 'package:resumate_flutter/features/quiz/model/skills_category.dart';
import 'package:resumate_flutter/features/quiz/view/pages/test_results.dart';
import 'package:resumate_flutter/features/quiz/viewmodel/results_controller.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  final resultsController = Get.put(ResultsController());
  Map<int, int> selectedAnswers = {};

  void selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentIndex] = index;
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  Map<String, double> calculateResults() {
    Map<String, double> scores = {"frontend": 0.0, "backend": 0.0, "ml": 0.0};

    Map<String, double> maxScores = {
      "frontend": 0.0,
      "backend": 0.0,
      "ml": 0.0,
    };

    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers.containsKey(i)) {
        int answerIndex = selectedAnswers[i]!;
        Question question = questions[i];

        question.categoryScores.forEach((category, values) {
          scores[category] = (scores[category] ?? 0) + values[answerIndex];

          double maxValue = values.reduce(
            (max, value) => value > max ? value : max,
          );
          maxScores[category] = (maxScores[category] ?? 0) + maxValue;
        });
      }
    }

    Map<String, double> percentages = {};
    scores.forEach((category, score) {
      percentages[category] = (score / maxScores[category]!) * 100;
    });

    return percentages;
  }

  String determineLevel(double percentage) {
    if (percentage < 50) {
      return "Junior";
    } else if (percentage < 75) {
      return "Mid-level";
    } else {
      return "Senior";
    }
  }

  List<String> getSkillRecommendations(String category, String level) {
    if (level == "Junior") {
      return skillCategories[category]!.juniorSkills;
    } else if (level == "Mid-level") {
      return skillCategories[category]!.midLevelSkills;
    } else {
      return skillCategories[category]!.seniorSkills;
    }
  }

  void finishQuiz() {
    if (selectedAnswers.length < questions.length) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Incomplete Quiz"),
              content: Text(
                "Please answer all questions to get accurate results.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"),
                ),
              ],
            ),
      );
      return;
    }

    Map<String, double> results = calculateResults();

    // Find category with highest score
    String topCategory = "frontend";
    results.forEach((category, score) {
      if (score > (results[topCategory] ?? 0)) {
        topCategory = category;
      }
    });

    String level = determineLevel(results[topCategory]!);
    List<String> recommendations = getSkillRecommendations(topCategory, level);

    resultsController.setResultsData(
      resultsData: results,
      topCat: topCategory,
      levelData: level,
      recs: recommendations,
      catNames: skillCategories.map((key, value) => MapEntry(key, value.name)),
    );

    resultsController.saveQuizResults(
      categoryNames: skillCategories.map(
        (key, value) => MapEntry(key, value.name),
      ),
      level: level,
      topCategory: topCategory,
      resultsData: results,
      recommendations: recommendations,
      selectedAnswers: selectedAnswers.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => TestResultsPage(
              results: results,
              topCategory: topCategory,
              level: level,
              recommendations: recommendations,
              categoryNames: skillCategories.map(
                (key, value) => MapEntry(key, value.name),
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final total = questions.length;
    final progress = (currentIndex + 1) / total;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                minHeight: 8,
                value: progress,
                backgroundColor: AppPallete.pink100,
                color: AppPallete.pink400,
              ),
              SizedBox(height: 8),
              Text(
                "Question ${currentIndex + 1}/$total",
                style: TextStyle(
                  color: AppPallete.pink400,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: NotificationsIcon(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfProDisplay(
              text: question.text,
              shouldTruncate: false,
              fontSize: 20,
              textAlignment: TextAlign.left,
              fontWeight: FontWeight.w700,
            ),

            spaceH30,
            ...List.generate(question.options.length, (index) {
              final selected = selectedAnswers[currentIndex] == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () => selectAnswer(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            selected
                                ? AppPallete.lightOrange100
                                : Colors.grey.shade300,
                      ),
                      color:
                          selected ? AppPallete.pink100 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: selected ? AppPallete.pink400 : Colors.grey,
                        ),
                        spaceW10,
                        Expanded(
                          child: SfProDisplay(
                            text: question.options[index],
                            shouldTruncate: false,
                            textAlignment: TextAlign.left,
                            fontSize: 16,
                            textColor:
                                selected ? AppPallete.pink400 : Colors.black,
                            fontWeight:
                                selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  RoundedButton(
                    label: "Back",
                    onTap: previousQuestion,
                    height: 50,
                    backgroundColor: AppPallete.pink100,
                    fontsize: 13,
                    textColor: AppPallete.pink400,
                    borderRadius: 30,
                    borderColor: AppPallete.pink400,
                    width: 150,
                  )
                else
                  SizedBox(width: 150),

                Obx(
                  () => RoundedButton(
                    isLoading: resultsController.isLoading.value,
                    label:
                        currentIndex == questions.length - 1
                            ? "Finish"
                            : "Next",
                    onTap:
                        currentIndex == questions.length - 1
                            ? finishQuiz
                            : nextQuestion,
                    height: 50,
                    backgroundColor: AppPallete.pink400,
                    fontsize: 13,
                    borderRadius: 30,
                    borderColor: AppPallete.pink400,
                    width: 150,
                  ),
                ),
              ],
            ),
            spaceH100,
          ],
        ),
      ),
    );
  }
}
