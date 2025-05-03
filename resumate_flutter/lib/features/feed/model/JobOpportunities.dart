import 'package:resumate_flutter/features/feed/model/Company.dart';

class JobOpportunity {
  final String id;
  final String title;
  final String description;
  final String type;
  final String mode;
  final DateTime expiryDate;
  final int applicants;
  final List<String> responsibilities;
  final String category;
  final String image;
  final Company company;
  final int v;

  JobOpportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.mode,
    required this.expiryDate,
    required this.applicants,
    required this.responsibilities,
    required this.category,
    required this.image,
    required this.company,
    required this.v,
  });

  factory JobOpportunity.fromJson(Map<String, dynamic> json) {
    return JobOpportunity(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      mode: json['mode'],
      expiryDate: DateTime.parse(json['expiryDate']),
      applicants: json['applicants'],
      responsibilities: List<String>.from(json['responsibilities']),
      category: json['category'],
      image: json['image'],
      company:
          json['company'] is Map
              ? Company.fromJson(json['company'])
              : Company(
                id: json['company'],
                name: '',
                numberOfEmployees: 0,
                email: '',
                phoneNumber: '',
                description: '',
                v: 0,
              ), // Fallback if only ID is provided
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'type': type,
      'mode': mode,
      'expiryDate': expiryDate.toIso8601String(),
      'applicants': applicants,
      'responsibilities': responsibilities,
      'category': category,
      'image': image,
      'company': company.toJson(),
      '__v': v,
    };
  }
}
