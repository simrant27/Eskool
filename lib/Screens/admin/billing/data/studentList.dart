class Student {
  final String id; // Corresponds to studentId in backend
  final String fullName;
  final String classAssigned;
  final String address;
  final String? parentID; // Nullable in case no parent is assigned
  final String? image;
  final bool? status;
  final DateTime createdAt;
  final List<String> fees; // List of Fee IDs

  Student({
    required this.id,
    required this.fullName,
    required this.classAssigned,
    required this.address,
    this.parentID,
    this.image,
    this.status,
    required this.createdAt,
    required this.fees,
  });

  // Factory method to create a Student object from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      fullName: json['fullName'],
      classAssigned: json['classAssigned'],
      address: json['address'],
      parentID: json['parentID'],
      image: json['image'],
      status: json['paid'],
      createdAt: DateTime.parse(json['createdAt']),
      fees: List<String>.from(json['fees']),
    );
  }

  // Method to convert a Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentId': id,
      'fullName': fullName,
      'classAssigned': classAssigned,
      'address': address,
      'parentID': parentID,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'fees': fees,
    };
  }
}
