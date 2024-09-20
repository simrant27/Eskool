// lib/models/student.dart

class Student {
  final String name;
  final String rollNo;
  final String grade;
  final String parentName;
  final String className; // Add this line

  Student({
    required this.name,
    required this.rollNo,
    required this.grade,
    required this.parentName,
    required this.className, // Add this line
  });
}
