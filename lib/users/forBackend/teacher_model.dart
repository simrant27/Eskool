class Teacher {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final List<String> subjectsTaught;
  final List<String> gradeAssigned;
  final String teacherID;
  final bool enrolled;
  final List<String> qualifications;
  final String address;
  final String username;
  final String? image;

  Teacher({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.subjectsTaught,
    required this.gradeAssigned,
    required this.teacherID,
    required this.enrolled,
    required this.qualifications,
    required this.address,
    required this.username,
    this.image = '',
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      subjectsTaught: List<String>.from(json['subjectsTaught']),
      gradeAssigned: List<String>.from(json['gradeAssigned']),
      teacherID: json['teacherID'],
      enrolled: json['enrolled'],
      qualifications: List<String>.from(json['qualifications']),
      address: json['address'],
      username: json['username'],
      image: json['image'] ?? '',
    );
  }
}
