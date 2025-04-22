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
