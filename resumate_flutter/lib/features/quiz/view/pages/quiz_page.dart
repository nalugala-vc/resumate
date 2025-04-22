import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';

// Enhanced question model that supports skill categorization
class Question {
  final String text;
  final List<String> options;
  final Map<String, List<double>> categoryScores;

  Question(this.text, this.options, this.categoryScores);
}

// Skill category model
class SkillCategory {
  final String name;
  final List<String> juniorSkills;
  final List<String> midLevelSkills;
  final List<String> seniorSkills;

  SkillCategory({
    required this.name,
    required this.juniorSkills,
    required this.midLevelSkills,
    required this.seniorSkills,
  });
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      "Which task do you enjoy the most?",
      [
        "Creating visually appealing user interfaces",
        "Building robust backend systems and APIs",
        "Working with data and creating predictive models",
        "Improving system performance and optimization",
      ],
      {
        "frontend": [4.0, 1.0, 1.0, 2.0],
        "backend": [1.0, 5.0, 1.0, 3.0],
        "ml": [1.0, 1.0, 5.0, 1.0],
      },
    ),
    Question(
      "Which programming language are you most comfortable with?",
      ["JavaScript/TypeScript", "Python", "Java/C#", "Go/Rust"],
      {
        "frontend": [5.0, 1.0, 2.0, 1.0],
        "backend": [2.0, 3.0, 4.0, 5.0],
        "ml": [1.0, 5.0, 2.0, 1.0],
      },
    ),
    Question(
      "What type of problem-solving appeals to you most?",
      [
        "Creating intuitive user experiences and interfaces",
        "Designing efficient system architectures",
        "Finding patterns in data and creating algorithms",
        "Building scalable distributed systems",
      ],
      {
        "frontend": [5.0, 1.0, 2.0, 1.0],
        "backend": [1.0, 5.0, 2.0, 5.0],
        "ml": [1.0, 2.0, 5.0, 2.0],
      },
    ),
    Question(
      "Which technology would you most likely learn next?",
      [
        "React or Vue.js",
        "Node.js or Django",
        "TensorFlow or PyTorch",
        "Kubernetes or Docker",
      ],
      {
        "frontend": [5.0, 2.0, 1.0, 1.0],
        "backend": [2.0, 4.0, 1.0, 5.0],
        "ml": [1.0, 1.0, 5.0, 2.0],
      },
    ),
    Question(
      "How would you describe your knowledge of algorithms?",
      [
        "Basic understanding of common algorithms",
        "Solid grasp of data structures and algorithms",
        "Advanced knowledge of optimization algorithms",
        "Expert in specialized algorithm domains",
      ],
      {
        "frontend": [4.0, 3.0, 2.0, 1.0],
        "backend": [2.0, 4.0, 4.0, 3.0],
        "ml": [1.0, 3.0, 5.0, 5.0],
      },
    ),
    Question(
      "Which of these tasks sounds most interesting?",
      [
        "Optimizing website performance and accessibility",
        "Designing database schemas and API structures",
        "Building and training machine learning models",
        "Setting up CI/CD pipelines and infrastructure",
      ],
      {
        "frontend": [5.0, 1.0, 1.0, 2.0],
        "backend": [2.0, 5.0, 1.0, 4.0],
        "ml": [1.0, 2.0, 5.0, 1.0],
      },
    ),
    Question(
      "How much experience do you have with CSS?",
      [
        "Expert - I can create complex layouts and animations",
        "Intermediate - I understand flexbox and grid",
        "Basic - I can make simple style changes",
        "Limited - I prefer to use frameworks or libraries",
      ],
      {
        "frontend": [5.0, 4.0, 3.0, 2.0],
        "backend": [1.0, 2.0, 3.0, 4.0],
        "ml": [1.0, 2.0, 3.0, 4.0],
      },
    ),
    Question(
      "How comfortable are you with database design?",
      [
        "Very comfortable with advanced concepts",
        "Comfortable with normalized schemas",
        "Basic understanding of database concepts",
        "Limited experience with databases",
      ],
      {
        "frontend": [2.0, 3.0, 4.0, 5.0],
        "backend": [5.0, 4.0, 3.0, 1.0],
        "ml": [3.0, 4.0, 3.0, 2.0],
      },
    ),
    Question(
      "How would you rate your knowledge of statistics?",
      [
        "Expert - I understand advanced statistical methods",
        "Intermediate - I can apply common statistical tests",
        "Basic - I understand descriptive statistics",
        "Limited - I have minimal statistics knowledge",
      ],
      {
        "frontend": [1.0, 2.0, 3.0, 5.0],
        "backend": [2.0, 3.0, 4.0, 3.0],
        "ml": [5.0, 4.0, 3.0, 1.0],
      },
    ),
    Question(
      "How many years of experience do you have in software development?",
      ["Less than 1 year", "1-3 years", "3-5 years", "More than 5 years"],
      {
        "frontend": [1.0, 2.0, 3.0, 5.0],
        "backend": [1.0, 2.0, 3.0, 5.0],
        "ml": [1.0, 2.0, 3.0, 5.0],
      },
    ),
  ];

  // Skill recommendations based on level and category
  final Map<String, SkillCategory> skillCategories = {
    "frontend": SkillCategory(
      name: "Frontend Developer",
      juniorSkills: [
        "Master HTML, CSS, and JavaScript fundamentals",
        "Learn a modern frontend framework (React, Vue, Angular)",
        "Understand responsive design principles",
        "Get familiar with frontend build tools",
      ],
      midLevelSkills: [
        "Deep dive into state management",
        "Learn advanced CSS (animations, grid layouts)",
        "Master component design patterns",
        "Improve accessibility knowledge",
      ],
      seniorSkills: [
        "Advanced performance optimization",
        "Architecture for large-scale applications",
        "Micro-frontend architecture",
        "Leading frontend projects and mentoring",
      ],
    ),
    "backend": SkillCategory(
      name: "Backend Developer",
      juniorSkills: [
        "Master a backend language (Python, Java, Node.js)",
        "Learn database fundamentals (SQL and NoSQL)",
        "Understand API design principles",
        "Get familiar with authentication/authorization",
      ],
      midLevelSkills: [
        "Design scalable database schemas",
        "Learn caching strategies",
        "Master API security best practices",
        "Understand containerization (Docker)",
      ],
      seniorSkills: [
        "Microservice architecture",
        "Event-driven systems",
        "Advanced database optimization",
        "System design for high availability",
      ],
    ),
    "ml": SkillCategory(
      name: "ML Engineer",
      juniorSkills: [
        "Master Python for data science",
        "Learn statistics fundamentals",
        "Understand machine learning algorithms",
        "Get familiar with data preprocessing techniques",
      ],
      midLevelSkills: [
        "Deep dive into neural networks",
        "Master feature engineering techniques",
        "Learn model deployment strategies",
        "Understand hyperparameter tuning",
      ],
      seniorSkills: [
        "Advanced deep learning architectures",
        "MLOps and production pipelines",
        "Distributed training systems",
        "Research and implement cutting-edge algorithms",
      ],
    ),
  };

  int currentIndex = 0;
  Map<int, int> selectedAnswers = {};

  void selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentIndex] = index;
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  Map<String, double> calculateResults() {
    Map<String, double> scores = {"frontend": 0.0, "backend": 0.0, "ml": 0.0};

    // Calculate total possible points by category
    Map<String, double> maxScores = {
      "frontend": 0.0,
      "backend": 0.0,
      "ml": 0.0,
    };

    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers.containsKey(i)) {
        int answerIndex = selectedAnswers[i]!;
        Question question = questions[i];

        // Add points for each category based on the selected answer
        question.categoryScores.forEach((category, values) {
          scores[category] = (scores[category] ?? 0) + values[answerIndex];

          // Find max possible score for this question in this category
          double maxValue = values.reduce(
            (max, value) => value > max ? value : max,
          );
          maxScores[category] = (maxScores[category] ?? 0) + maxValue;
        });
      }
    }

    // Convert to percentages
    Map<String, double> percentages = {};
    scores.forEach((category, score) {
      percentages[category] = (score / maxScores[category]!) * 100;
    });

    return percentages;
  }

  String determineLevel(double percentage) {
    if (percentage < 50) {
      return "Junior";
    } else if (percentage < 75) {
      return "Mid-level";
    } else {
      return "Senior";
    }
  }

  List<String> getSkillRecommendations(String category, String level) {
    if (level == "Junior") {
      return skillCategories[category]!.juniorSkills;
    } else if (level == "Mid-level") {
      return skillCategories[category]!.midLevelSkills;
    } else {
      return skillCategories[category]!.seniorSkills;
    }
  }

  void finishQuiz() {
    if (selectedAnswers.length < questions.length) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Incomplete Quiz"),
              content: Text(
                "Please answer all questions to get accurate results.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"),
                ),
              ],
            ),
      );
      return;
    }

    Map<String, double> results = calculateResults();

    // Find category with highest score
    String topCategory = "frontend";
    results.forEach((category, score) {
      if (score > (results[topCategory] ?? 0)) {
        topCategory = category;
      }
    });

    String level = determineLevel(results[topCategory]!);
    List<String> recommendations = getSkillRecommendations(topCategory, level);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ResultsPage(
              results: results,
              topCategory: topCategory,
              level: level,
              recommendations: recommendations,
              categoryNames: skillCategories.map(
                (key, value) => MapEntry(key, value.name),
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final total = questions.length;
    final progress = (currentIndex + 1) / total;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                minHeight: 8,
                value: progress,
                backgroundColor: AppPallete.pink100,
                color: AppPallete.pink400,
              ),
              SizedBox(height: 8),
              Text(
                "Question ${currentIndex + 1}/$total",
                style: TextStyle(
                  color: AppPallete.pink400,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: NotificationsIcon(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfProDisplay(
              text: question.text,
              fontSize: 20,
              textAlignment: TextAlign.left,
              fontWeight: FontWeight.w700,
            ),

            spaceH30,
            ...List.generate(question.options.length, (index) {
              final selected = selectedAnswers[currentIndex] == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () => selectAnswer(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            selected
                                ? AppPallete.lightOrange100
                                : Colors.grey.shade300,
                      ),
                      color:
                          selected ? AppPallete.pink100 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: selected ? AppPallete.pink400 : Colors.grey,
                        ),
                        spaceW10,
                        Expanded(
                          child: SfProDisplay(
                            text: question.options[index],
                            shouldTruncate: false,
                            textAlignment: TextAlign.left,
                            fontSize: 16,
                            textColor:
                                selected ? AppPallete.pink400 : Colors.black,
                            fontWeight:
                                selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  RoundedButton(
                    label: "Back",
                    onTap: previousQuestion,
                    height: 50,
                    backgroundColor: AppPallete.pink100,
                    fontsize: 13,
                    textColor: AppPallete.pink400,
                    borderRadius: 30,
                    borderColor: AppPallete.pink400,
                    width: 150,
                  )
                else
                  SizedBox(width: 150),

                RoundedButton(
                  label:
                      currentIndex == questions.length - 1 ? "Finish" : "Next",
                  onTap:
                      currentIndex == questions.length - 1
                          ? finishQuiz
                          : nextQuestion,
                  height: 50,
                  backgroundColor: AppPallete.pink400,
                  fontsize: 13,
                  borderRadius: 30,
                  borderColor: AppPallete.pink400,
                  width: 150,
                ),
              ],
            ),
            spaceH20,
          ],
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final Map<String, double> results;
  final String topCategory;
  final String level;
  final List<String> recommendations;
  final Map<String, String> categoryNames;

  const ResultsPage({
    Key? key,
    required this.results,
    required this.topCategory,
    required this.level,
    required this.recommendations,
    required this.categoryNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort categories by score (descending)
    List<MapEntry<String, double>> sortedResults =
        results.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppPallete.pink400),
        title: Text(
          "Your Results",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.pink100,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(topCategory),
                        size: 60,
                        color: AppPallete.pink400,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${results[topCategory]!.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.pink400,
                        ),
                      ),
                      Text(
                        categoryNames[topCategory]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Your Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Based on your answers, you most closely align with a ${level.toLowerCase()} ${categoryNames[topCategory]!.toLowerCase()}.",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),

            Text(
              "Category Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            ...sortedResults
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryNames[entry.key]!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${entry.value.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppPallete.pink400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: entry.value / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: _getCategoryColor(entry.key),
                          minHeight: 10,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            SizedBox(height: 30),

            Text(
              "Skills to Focus On",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            ...recommendations
                .map(
                  (skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_right,
                          color: AppPallete.pink400,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(skill, style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            SizedBox(height: 30),

            Center(
              child: RoundedButton(
                label: "Back to Home",
                onTap:
                    () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                height: 50,
                backgroundColor: AppPallete.pink400,
                fontsize: 16,
                borderRadius: 30,
                borderColor: AppPallete.pink400,
                width: 200,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "frontend":
        return Icons.web;
      case "backend":
        return Icons.dns;
      case "ml":
        return Icons.psychology;
      default:
        return Icons.code;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "frontend":
        return Colors.blue;
      case "backend":
        return Colors.green;
      case "ml":
        return Colors.purple;
      default:
        return AppPallete.pink400;
    }
  }
}
