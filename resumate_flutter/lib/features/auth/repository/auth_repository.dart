import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:http/http.dart' as http;
import 'package:resumate_flutter/features/auth/model/User.dart';

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

  Future<Either<AppFailure, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    final headers = await AppConfigs.authorizedHeaders();
    final body = jsonEncode({"email": email, "password": password});

    try {
      final response = await http.post(
        Uri.parse(AppConfigs.appBaseUrl + Endpoints.signIn),
        headers: headers,
        body: body,
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200 || resBodyMap['success'] != true) {
        final message = resBodyMap['message'] ?? 'Something went wrong';
        return Left(AppFailure(message));
      }

      final token = resBodyMap['token'] as String;
      final requesterInfo =
          resBodyMap['requesterInformation'] as Map<String, dynamic>;
      final id = requesterInfo['id'] as String;
      final receivedParams =
          requesterInfo['receivedParams'] as Map<String, dynamic>;
      final userEmail = receivedParams['email'] as String;

      final userModel = UserModel(id: id, email: userEmail, token: token);

      return Right(userModel);
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
