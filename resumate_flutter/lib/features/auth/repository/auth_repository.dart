import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Either<AppFailure, String>> signup({
    required String email,
    required String password,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();
    final body = jsonEncode({"email": email, "password": password});

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.signUp),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      return Right(resBodyMap['message'] ?? 'Registration successful');
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> verifyOTP({
    required String OTPCode,
    required String email,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();
    final body = jsonEncode({"email": email, "otpCode": OTPCode});

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.verifyOTP),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      return Right(true);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
