class Job {
  final String companyName;
  final String employeeCount;
  final String jobTitle;
  final String jobDescription;
  final double matchPercent;
  final String imageUrl;

  Job({
    required this.companyName,
    required this.employeeCount,
    required this.jobTitle,
    required this.jobDescription,
    required this.matchPercent,
    required this.imageUrl,
  });
}

final List<Job> jobs = [
  Job(
    companyName: "Techify",
    employeeCount: "150",
    jobTitle: "Frontend Developer",
    jobDescription: "Join our UI team to build beautiful Flutter interfaces.",
    matchPercent: 0.8,
    imageUrl: "https://images.unsplash.com/photo-1557804506-669a67965ba0",
  ),
  Job(
    companyName: "InnoTech",
    employeeCount: "300",
    jobTitle: "Backend Engineer",
    jobDescription: "Work with scalable APIs and cloud infrastructure.",
    matchPercent: 0.75,
    imageUrl: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
  ),
  // Add more Job instances as needed
];
