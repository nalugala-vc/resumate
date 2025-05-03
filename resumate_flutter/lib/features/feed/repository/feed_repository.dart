import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:resumate_flutter/features/feed/model/JobOpportunities.dart';

class FeedRepository {
  Future<Either<AppFailure, JobOpportunity>> uploadResume() async {
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
}
