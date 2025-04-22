import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/quiz/model/category_metric.dart';
import 'package:resumate_flutter/features/quiz/model/question.dart';
import 'package:resumate_flutter/features/quiz/model/skills_category.dart';
import 'package:resumate_flutter/features/quiz/view/pages/test_results.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  Map<int, int> selectedAnswers = {};

  List<CategoryMetric> calculateCategoryMetrics(String category) {
    // Define which questions correspond to which metrics

    List<CategoryMetric> metrics = [];

    // Calculate each metric score
    metricQuestionMap[category]?.forEach((metricName, questionIndices) {
      double totalScore = 0;
      double maxPossibleScore = 0;

      for (int questionIndex in questionIndices) {
        if (questionIndex < questions.length &&
            selectedAnswers.containsKey(questionIndex)) {
          int answerIndex = selectedAnswers[questionIndex]!;

          // Add the score for this question
          if (questions[questionIndex].categoryScores.containsKey(category)) {
            double score =
                questions[questionIndex].categoryScores[category]![answerIndex];
            totalScore += score;

            // Calculate max possible score for this question
            double maxScore = questions[questionIndex].categoryScores[category]!
                .reduce((max, value) => value > max ? value : max);
            maxPossibleScore += maxScore;
          }
        }
      }

      // Calculate percentage
      double percentage = (totalScore / maxPossibleScore) * 100;

      // Add the metric
      metrics.add(
        CategoryMetric(
          name: metricName,
          score: percentage,
          description: metricDescriptions[category]?[metricName] ?? "",
        ),
      );
    });

    return metrics;
  }

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
              calculateCategoryMetrics: calculateCategoryMetrics,
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

                RoundedButton(
                  label:
                      currentIndex == questions.length - 1 ? "Finish" : "Next",
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
              ],
            ),
            spaceH100,
          ],
        ),
      ),
    );
  }
}

// Update your ResultsPage class
class ResultsPage extends StatelessWidget {
  final Map<String, double> results;
  final String topCategory;
  final String level;
  final List<String> recommendations;
  final Map<String, String> categoryNames;
  final Function(String) calculateCategoryMetrics;

  const ResultsPage({
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
    // Sort categories by score (descending)
    List<MapEntry<String, double>> sortedResults =
        results.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppPallete.pink400),
        title: Text(
          "Your Results",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.pink100,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(topCategory),
                        size: 60,
                        color: AppPallete.pink400,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${results[topCategory]!.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.pink400,
                        ),
                      ),
                      Text(
                        categoryNames[topCategory]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Your Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Based on your answers, you most closely align with a ${level.toLowerCase()} ${categoryNames[topCategory]!.toLowerCase()}.",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),

            Text(
              "Category Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            ...sortedResults
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryNames[entry.key]!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${entry.value.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppPallete.pink400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: entry.value / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: _getCategoryColor(entry.key),
                          minHeight: 10,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            SizedBox(height: 30),

            // Detailed Skills Breakdown Section
            Text(
              "Skills Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Create tabs for each category
            DefaultTabController(
              length: results.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: AppPallete.pink400,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppPallete.pink400,
                    tabs:
                        sortedResults
                            .map((entry) => Tab(text: categoryNames[entry.key]))
                            .toList(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    child: TabBarView(
                      children:
                          sortedResults.map((entry) {
                            // Get metrics for this category
                            List<CategoryMetric> metrics =
                                calculateCategoryMetrics(entry.key);

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: metrics.length,
                              itemBuilder: (context, index) {
                                final metric = metrics[index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            metric.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getScoreColor(
                                                metric.score,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              "${metric.score.toStringAsFixed(0)}%",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        metric.description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          Container(
                                            height: 8,
                                            width:
                                                (metric.score / 100) *
                                                (MediaQuery.of(
                                                      context,
                                                    ).size.width -
                                                    80),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _getScoreColor(
                                                metric.score,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        _getScoreLabel(metric.score),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: _getScoreColor(metric.score),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Skills to Focus On",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            ...recommendations
                .map(
                  (skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_right,
                          color: AppPallete.pink400,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(skill, style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            SizedBox(height: 30),

            Center(
              child: RoundedButton(
                label: "Back to Home",
                onTap:
                    () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                height: 50,
                backgroundColor: AppPallete.pink400,
                fontsize: 16,
                borderRadius: 30,
                borderColor: AppPallete.pink400,
                width: 200,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "frontend":
        return Icons.web;
      case "backend":
        return Icons.dns;
      case "ml":
        return Icons.psychology;
      default:
        return Icons.code;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "frontend":
        return Colors.blue;
      case "backend":
        return Colors.green;
      case "ml":
        return Colors.purple;
      default:
        return AppPallete.pink400;
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 80) {
      return Colors.green;
    } else if (score >= 60) {
      return Colors.orange;
    } else if (score >= 40) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  String _getScoreLabel(double score) {
    if (score >= 80) {
      return "Excellent";
    } else if (score >= 60) {
      return "Good";
    } else if (score >= 40) {
      return "Developing";
    } else {
      return "Needs Improvement";
    }
  }
}
