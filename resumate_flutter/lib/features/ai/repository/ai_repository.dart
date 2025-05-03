import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:resumate_flutter/features/ai/model/ResumeResults.dart';
import 'package:http/http.dart' as http;

class AiRepository {
  Future<Either<AppFailure, ResumeResults>> uploadResume({
    required String resume,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();
    final body = jsonEncode({"resume_text": resume});

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.uploadResume),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      print(resBodyMap);

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      print(resBodyMap);

      final resumeResults = ResumeResults.fromJson(resBodyMap);
      return Right(resumeResults);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, String>> chatWithAI({
    required String message,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();
    final body = jsonEncode({"message": message});

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.chatWithAI),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      print(resBodyMap);

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      print(resBodyMap);

      return Right(resBodyMap['reply']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
