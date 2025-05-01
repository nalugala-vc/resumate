// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Mentor {
  final String id;
  final String image;
  final String name;
  final String jobRole;
  final String company;
  final String about;
  final List<String> skills;

  Mentor({
    required this.id,
    required this.image,
    required this.name,
    required this.jobRole,
    required this.company,
    required this.about,
    required this.skills,
  });

  Mentor copyWith({
    String? id,
    String? image,
    String? name,
    String? jobRole,
    String? company,
    String? about,
    List<String>? skills,
  }) {
    return Mentor(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      jobRole: jobRole ?? this.jobRole,
      company: company ?? this.company,
      about: about ?? this.about,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'jobRole': jobRole,
      'company': company,
      'about': about,
      'skills': skills,
    };
  }

  factory Mentor.fromMap(Map<String, dynamic> map) {
    return Mentor(
      id: map['_id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      jobRole: map['jobRole'] as String,
      company: map['company'] as String,
      about: map['about'] as String,
      skills: List<String>.from(map['skills'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Mentor.fromJson(String source) =>
      Mentor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Mentor(id: $id, image: $image, name: $name, jobRole: $jobRole, company: $company, about: $about, skills: $skills)';
  }

  @override
  bool operator ==(covariant Mentor other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.image == image &&
        other.name == name &&
        other.jobRole == jobRole &&
        other.company == company &&
        other.about == about &&
        listEquals(other.skills, skills);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        jobRole.hashCode ^
        company.hashCode ^
        about.hashCode ^
        skills.hashCode;
  }
}
