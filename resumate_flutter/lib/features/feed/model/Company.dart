class Company {
  final String id;
  final String name;
  final int numberOfEmployees;
  final String email;
  final String phoneNumber;
  final String description;
  final int v;

  Company({
    required this.id,
    required this.name,
    required this.numberOfEmployees,
    required this.email,
    required this.phoneNumber,
    required this.description,
    required this.v,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'],
      name: json['name'],
      numberOfEmployees: json['numberOfEmployees'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      description: json['description'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'numberOfEmployees': numberOfEmployees,
      'email': email,
      'phoneNumber': phoneNumber,
      'description': description,
      '__v': v,
    };
  }
}
