// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String token;

  UserModel({
    required this.id,
    required this.email,
    required this.token,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'email': email, 'token': token};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({String? id, String? email, String? token, String? name}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, email: $email, token: $token)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ token.hashCode;
}
