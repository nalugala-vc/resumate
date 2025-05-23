import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:resumate_flutter/features/feed/model/JobOpportunities.dart';

class FeedRepository {
  Future<Either<AppFailure, List<JobOpportunity>>>
  fetchJobOpportunities() async {
    final headers = await AppConfigs.authorizedHeaders();

    try {
      final response = await http.get(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.getAllJobOpportunities),
        headers: headers,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      final jobsJson = resBodyMap['jobs'] as List<dynamic>;

      final jobOpportunities =
          jobsJson
              .map(
                (job) => JobOpportunity.fromJson(job as Map<String, dynamic>),
              )
              .toList();

      return Right(jobOpportunities);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> applyForJob({
    required String jobId,
    required String userId,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();

    final body = jsonEncode({"jobId": jobId, "userId": userId});

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.applyForJob),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200 || resBodyMap['success'] != true) {
        final message = resBodyMap['message'] ?? 'Failed to apply for job';
        return Left(AppFailure(message));
      }

      return Right(true);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
