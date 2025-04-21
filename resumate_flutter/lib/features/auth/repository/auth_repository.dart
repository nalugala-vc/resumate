import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:resumate_flutter/core/api/config.dart';
import 'package:resumate_flutter/core/api/endpoints.dart';
import 'package:resumate_flutter/core/utils/failure/failure.dart';
import 'package:resumate_flutter/features/auth/model/User.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String email,
    required String name,
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

      if (response.statusCode != 201) {
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
