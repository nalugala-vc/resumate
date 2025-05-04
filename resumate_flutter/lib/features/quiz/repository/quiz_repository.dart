import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:http/http.dart' as http;
import 'package:resumate_flutter/features/quiz/model/quiz_results.dart';

class QuizRepository {
  Future<Either<AppFailure, QuizResults>> saveQuizResults({
    required String token,
    required Map<String, double> results,
    required String topCategory,
    required String level,
    required List<String> recommendations,
    required Map<String, String> categoryNames,
    required Map<String, int> selectedAnswers,
  }) async {
    String recommendationsString = recommendations.join('||');

    final headers = await AppConfigs.authorizedHeaders();

    final body = jsonEncode({
      "token": token,
      "results": results,
      "topCategory": topCategory,
      "level": level,
      "recommendations": recommendationsString,
      "categoryNames": categoryNames,
      "selectedAnswers": selectedAnswers,
    });

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.saveQuizResults),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      print(response);
      print(resBodyMap);

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      final userInfo = resBodyMap['user'] as Map<String, dynamic>;

      print(resBodyMap);
      final quizResultsMap = userInfo['quizResults'] as Map<String, dynamic>?;
      final quizResults =
          quizResultsMap != null ? QuizResults.fromMap(quizResultsMap) : null;

      return Right(quizResults!);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
