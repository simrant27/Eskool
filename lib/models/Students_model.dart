import 'ResultModel.dart';

class Student {
  // String? id;
  final String studentId;
  final String fullName;
  final String classAssigned;
  final String parentName;
  String? rollNumber;
  String? imageUrl;
  List<Result>? results; // Add rollNumber as a nullable field

  Student(
      {required this.studentId,
      required this.fullName,
      required this.classAssigned,
      required this.parentName,
      this.rollNumber,
      this.imageUrl,
      this.results // Include rollNumber in the constructor
      });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        studentId: json['_id'],
        rollNumber: json['rollNumber'],
        fullName: json['fullName'],
        classAssigned: json['classAssigned'],
        parentName:
            json['parentID'] != null ? json['parentID']['fullName'] : 'Unknown',
        imageUrl: json['imageUrl'],
        results: []);
  }
}
