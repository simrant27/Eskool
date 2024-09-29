class Teacher {
  String? fullName;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? address;
  List<String>? qualifications;
  List<String>? subjectsTaught;
  bool enrolled;
  String? teacherID;
  String? image;

  Teacher({
    this.fullName,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.address,
    this.qualifications,
    this.subjectsTaught,
    this.enrolled = false,
    this.teacherID,
    this.image,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      address: json['address'],
      qualifications: List<String>.from(json['qualifications'] ?? []),
      subjectsTaught: List<String>.from(json['subjectsTaught'] ?? []),
      enrolled: json['enrolled'],
      teacherID: json['teacherID'], // Assuming the ID from MongoDB
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'teacherID': teacherID,
      'username': username,
      'password': password,
      'address': address,
      'qualifications': qualifications,
      'subjectsTaught': subjectsTaught,
      'enrolled': enrolled,
      'image': image,
    };
  }
}
