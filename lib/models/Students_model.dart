class Student {
  final String studentId;
  final String fullName;
  final String classAssigned;
  final String parentName;
  String? rollNumber;
  String? imageUrl; // Add rollNumber as a nullable field

  Student({
    required this.studentId,
    required this.fullName,
    required this.classAssigned,
    required this.parentName,
    this.rollNumber,
    this.imageUrl, // Include rollNumber in the constructor
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'],
      rollNumber: json['rollNumber'],
      fullName: json['fullName'],
      classAssigned: json['classAssigned'],
      parentName:
          json['parentID'] != null ? json['parentID']['fullName'] : 'Unknown',
      imageUrl: json['imageUrl'],
    );
  }
}
