// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:resumate_flutter/features/quiz/model/quiz_results.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String token;
  final QuizResults? quizResults;

  UserModel({
    required this.id,
    required this.email,
    required this.token,
    required this.name,
    this.quizResults,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'token': token,
      if (quizResults != null) 'quizResults': quizResults!.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
      quizResults:
          map['quizResults'] != null
              ? QuizResults.fromMap(map['quizResults'])
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? email,
    String? token,
    String? name,
    QuizResults? quizResults,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      quizResults: quizResults ?? this.quizResults,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, email: $email, token: $token, quizResults: $quizResults)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ token.hashCode;
}
