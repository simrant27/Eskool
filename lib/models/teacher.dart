class Teacher {
  String fullName;
  String email;
  String phone;
  List<String> subjectsTaught;
  List<String> gradeAssigned;
  String teacherID;
  bool enrolled;
  List<String> qualifications;
  String address;
  String username;
  String password;
  String image;

  Teacher({
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
    required this.password,
    this.image = "",
  });
}
