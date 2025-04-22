class Question {
  final String text;
  final List<String> options;
  final Map<String, List<double>> categoryScores;

  Question(this.text, this.options, this.categoryScores);
}

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
