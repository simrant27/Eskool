class Teacher {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String subjectsTaught;
  final String teacherID;
  final String employmentDate;
  final String qualifications;
  final String username;
  final String password;
  final String? imagePath; // Optional for photo upload

  Teacher({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.subjectsTaught,
    required this.teacherID,
    required this.employmentDate,
    required this.qualifications,
    required this.username,
    required this.password,
    this.imagePath,
  });

  Map<String, String> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'subjectsTaught': subjectsTaught,
      'teacherID': teacherID,
      'employmentDate': employmentDate,
      'qualifications': qualifications,
      'username': username,
      'password': password,
    };
  }
}
