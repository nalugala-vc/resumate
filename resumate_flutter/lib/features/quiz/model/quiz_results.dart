class QuizResults {
  final Map<String, double> results;
  final String topCategory;
  final String level;
  final List<String> recommendations;
  final Map<String, String> categoryNames;
  final Map<String, int> selectedAnswers;

  QuizResults({
    required this.results,
    required this.topCategory,
    required this.level,
    required this.recommendations,
    required this.categoryNames,
    required this.selectedAnswers,
  });

  factory QuizResults.fromMap(Map<String, dynamic> map) {
    return QuizResults(
      results: Map<String, double>.from(
        map['results'].map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
      topCategory: map['topCategory'],
      level: map['level'],
      recommendations: List<String>.from(map['recommendations']),
      categoryNames: Map<String, String>.from(map['categoryNames']),
      selectedAnswers: Map<String, int>.from(
        (map['selectedAnswers'] ?? {}).map(
          (key, value) => MapEntry(key.toString(), value as int),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'results': results,
      'topCategory': topCategory,
      'level': level,
      'recommendations': recommendations,
      'categoryNames': categoryNames,
      'selectedAnswers': selectedAnswers.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
    };
  }
}
