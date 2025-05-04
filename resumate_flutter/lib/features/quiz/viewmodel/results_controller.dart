import 'dart:convert';

import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/auth/viewmodel/auth_controller.dart';
import 'package:resumate_flutter/features/quiz/model/category_metric.dart';
import 'package:resumate_flutter/features/quiz/model/question.dart';
import 'package:resumate_flutter/features/quiz/repository/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsController extends BaseController {
  static ResultsController get instance => Get.find();
  final authController = Get.find<SignInController>();
  // Observable data
  final results = <String, double>{}.obs;
  final topCategory = ''.obs;
  final level = ''.obs;
  final recommendations = <String>[].obs;
  final categoryNames = <String, String>{}.obs;
  final QuizRepository _quizRepository = QuizRepository();

  RxList mentors = [].obs;
  final errorMessage = ''.obs;
  bool get hasResults => results.isNotEmpty;

  List<CategoryMetric> calculateCategoryMetrics(
    String category,
    Map<String, int> selectedAnswers,
  ) {
    List<CategoryMetric> metrics = [];
    final convertedAnswers = convertSelectedAnswers(selectedAnswers);

    metricQuestionMap[category]?.forEach((metricName, questionIndices) {
      double totalScore = 0;
      double maxPossibleScore = 0;

      for (int questionIndex in questionIndices) {
        if (questionIndex < questions.length &&
            convertedAnswers.containsKey(questionIndex)) {
          int answerIndex = convertedAnswers[questionIndex]!;

          if (questions[questionIndex].categoryScores.containsKey(category)) {
            double score =
                questions[questionIndex].categoryScores[category]![answerIndex];
            totalScore += score;
            double maxScore = questions[questionIndex].categoryScores[category]!
                .reduce((max, value) => value > max ? value : max);
            maxPossibleScore += maxScore;
          }
        }
      }
      double percentage = (totalScore / maxPossibleScore) * 100;

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

  Map<int, int> convertSelectedAnswers(Map<String, int> selectedAnswers) {
    return selectedAnswers.map((key, value) => MapEntry(int.parse(key), value));
  }

  double getReadinessForTrack(String trackKey) {
    return results[trackKey] ?? 0;
  }

  void setResultsData({
    required Map<String, double> resultsData,
    required String topCat,
    required String levelData,
    required List<String> recs,
    required Map<String, String> catNames,
  }) {
    results.value = resultsData;
    topCategory.value = topCat;
    level.value = levelData;
    recommendations.value = recs;
    categoryNames.value = catNames;
  }

  Future<void> saveQuizResults({
    required Map<String, String> categoryNames,
    required String level,
    required String topCategory,
    required Map<String, double> resultsData,
    required List<String> recommendations,
    required Map<String, int> selectedAnswers,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('USER_TOKEN');
      setBusy(true);
      errorMessage.value = '';

      final res = await _quizRepository.saveQuizResults(
        token: token!,
        categoryNames: categoryNames,
        level: level,
        recommendations: recommendations,
        results: resultsData,
        topCategory: topCategory,
        selectedAnswers: selectedAnswers,
      );

      res.fold(
        (failure) {
          print(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (results) async {
          print('results controller $results');
          final currentUser = authController.currentUser.value;
          if (currentUser != null) {
            final updatedUser = currentUser.copyWith(quizResults: results);

            // ✅ Update observable user
            authController.currentUser(updatedUser);

            // ✅ Persist updated user to SharedPreferences
            final updatedJson = updatedUser.toJson(); // returns a Map
            final updatedString = jsonEncode(updatedJson);
            await prefs.setString('USER_MODEL', updatedString);

            print(
              'Immediately after update: ${authController.currentUser.value?.quizResults}',
            );

            print('updated user $updatedUser');
            print('current user ${authController.currentUser.value}');
          }

          authController.update();
          Get.snackbar('Success', 'Saved results successfully');
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      setBusy(false);
    }
  }
}
