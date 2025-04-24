class CategoryMetric {
  final String name;
  final double score; // Percentage score (0-100)
  final String description;

  CategoryMetric({
    required this.name,
    required this.score,
    required this.description,
  });

  @override
  String toString() {
    return 'CategoryMetric(name: $name, score: $score,description : $description)';
  }
}

Map<String, Map<String, List<int>>> metricQuestionMap = {
  "frontend": {
    "UI/UX Skills": [0, 2, 5],
    "Frontend Technologies": [1, 3, 6],
    "Technical Knowledge": [4, 7, 8],
  },
  "backend": {
    "System Architecture": [0, 2, 5],
    "Database Knowledge": [4, 7, 8],
    "Backend Technologies": [1, 3, 6],
  },
  "ml": {
    "Statistical Knowledge": [4, 8, 9],
    "ML Frameworks": [1, 3, 5],
    "Algorithm Design": [2, 4, 7],
  },
};

// Define metrics descriptions
Map<String, Map<String, String>> metricDescriptions = {
  "frontend": {
    "UI/UX Skills": "Creating intuitive interfaces and user experiences",
    "Frontend Technologies": "Knowledge of modern frameworks and tools",
    "Technical Knowledge": "Understanding of core concepts and best practices",
  },
  "backend": {
    "System Architecture": "Designing robust and scalable systems",
    "Database Knowledge": "Working with data storage and retrieval systems",
    "Backend Technologies": "Using appropriate frameworks and tools",
  },
  "ml": {
    "Statistical Knowledge": "Understanding of mathematical foundations",
    "ML Frameworks": "Experience with machine learning libraries",
    "Algorithm Design": "Creating and optimizing algorithms",
  },
};
