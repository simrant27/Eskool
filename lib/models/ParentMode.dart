class Parent {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? address;
  List<String>? children;
  // String? teacherID;
  String? image;

  Parent({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.children,
    this.address,

    // this.teacherID,
    this.image,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      address: json['address'],
      children: json['children'] != null
          ? List<String>.from(json['children'].map((child) => child['_id']))
          : [],

      // teacherID: json['teacherID'], // Assuming the ID from MongoDB
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      // 'teacherID': teacherID,
      'children': children,
      'username': username,
      'password': password,
      'address': address,

      'image': image,
    };
  }
}
