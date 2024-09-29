class Student {
  final String? id;
  final String? fullName;
  final String? classAssigned;
  final String? studentId;
  final String? address;
  final String? gender;
  final String? parentID;
  final String? image;
  final List<String>? fees; // Fee IDs
  final List<String>? results; // Result IDs

  Student({
    this.id,
    this.fullName,
    this.classAssigned,
    this.studentId,
    this.address,
    this.gender,
    this.parentID,
    this.image,
    this.fees,
    this.results,
  });

  // Factory method to create a Student object from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      fullName: json['fullName'],
      classAssigned: json['classAssigned'],
      studentId: json['studentId'],
      address: json['address'],
      gender: json['gender'],
      parentID: json['parentID'],
      image: json['image'],
      fees: json['fees'] != null ? List<String>.from(json['fees']) : [],
      results: json['result'] != null ? List<String>.from(json['result']) : [],
    );
  }

  // Method to convert Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'classAssigned': classAssigned,
      'studentId': studentId,
      'address': address,
      'gender': gender,
      'parentID': parentID,
      'image': image,
      'fees': fees,
      'result': results,
    };
  }
}
