class ResumeResults {
  final int overallScore;
  final int structure;
  final int languageClarity;
  final int impact;
  final int atsCompatibility;
  final ResumeDetails details;

  ResumeResults({
    required this.overallScore,
    required this.structure,
    required this.languageClarity,
    required this.impact,
    required this.atsCompatibility,
    required this.details,
  });

  factory ResumeResults.fromJson(Map<String, dynamic> json) {
    return ResumeResults(
      overallScore: json['overall_score'],
      structure: json['structure'],
      languageClarity: json['language_clarity'],
      impact: json['impact'],
      atsCompatibility: json['ats_compatibility'],
      details: ResumeDetails.fromJson(json['details']),
    );
  }
}

class ResumeDetails {
  final ResumeCategory structure;
  final ResumeCategory languageClarity;
  final ResumeCategory impact;
  final ResumeCategory atsCompatibility;

  ResumeDetails({
    required this.structure,
    required this.languageClarity,
    required this.impact,
    required this.atsCompatibility,
  });

  factory ResumeDetails.fromJson(Map<String, dynamic> json) {
    return ResumeDetails(
      structure: ResumeCategory.fromJson(json['structure']),
      languageClarity: ResumeCategory.fromJson(json['language_clarity']),
      impact: ResumeCategory.fromJson(json['impact']),
      atsCompatibility: ResumeCategory.fromJson(json['ats_compatibility']),
    );
  }
}

class ResumeCategory {
  final String description;
  final List<Recommendation> recommendations;

  ResumeCategory({required this.description, required this.recommendations});

  factory ResumeCategory.fromJson(Map<String, dynamic> json) {
    return ResumeCategory(
      description: json['description'],
      recommendations:
          (json['recommendations'] as List)
              .map((e) => Recommendation.fromJson(e))
              .toList(),
    );
  }
}

class Recommendation {
  final String title;
  final String description;

  Recommendation({required this.title, required this.description});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['title'],
      description: json['description'],
    );
  }
}
