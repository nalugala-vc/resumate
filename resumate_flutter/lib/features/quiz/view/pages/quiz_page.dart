import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question("What type of work excites you the most", [
      "Building things (Engineering, Design)",
      "Solving problems (Data, AI, Research)",
      "Helping people (Healthcare, Teaching, Social Work)",
      "Leading projects (Management, Business)",
    ]),
    Question("What environment do you prefer to work in?", [
      "Fast-paced and dynamic",
      "Calm and structured",
      "Collaborative and social",
      "Independent and focused",
    ]),
    Question("Which skill do you value most?", [
      "Creativity",
      "Analytical thinking",
      "Empathy",
      "Leadership",
    ]),
  ];

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

  void finishQuiz() {
    int correctAnswers = selectedAnswers.length;
    double percentage = (correctAnswers / questions.length) * 100;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Quiz Completed"),
            content: Text("You scored ${percentage.toStringAsFixed(0)}%"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
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
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.pink.shade100,
            color: Colors.pink,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.notifications_none, color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
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
                                ? Colors.pink.shade200
                                : Colors.grey.shade300,
                      ),
                      color:
                          selected ? Colors.pink.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: selected ? Colors.pink : Colors.grey,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: selected ? Colors.pink : Colors.black,
                              fontWeight:
                                  selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  ElevatedButton(
                    onPressed: previousQuestion,
                    child: Text("Back"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade100,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed:
                      currentIndex == questions.length - 1
                          ? finishQuiz
                          : nextQuestion,
                  child: Text(
                    currentIndex == questions.length - 1 ? "Finish" : "Next",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;

  Question(this.text, this.options);
}
