import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:http/http.dart' as http;
import 'package:resumate_flutter/features/mentorship/model/Mentor.dart';

class MentorshipRepo {
  Future<Either<AppFailure, List<Mentor>>> fetchMentors() async {
    final headers = await AppConfigs.authorizedHeaders();

    try {
      final response = await http.get(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.fetchMentor),
        headers: headers,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      print(resBodyMap);

      final mentorsJson = resBodyMap['mentors'] as List<dynamic>;
      final mentors = mentorsJson.map((e) => Mentor.fromMap(e)).toList();
      return Right(mentors);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> bookSession({
    required String userId,
    required String mentorId,
    required String date,
    required String time,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();
    final body = jsonEncode({
      "userId": userId,
      "mentorId": mentorId,
      "date": date,
      "time": time,
    });

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.bookMentorSession),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      return Right(resBodyMap['success']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
