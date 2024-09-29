class Parent {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? address;

  // String? teacherID;
  String? image;

  Parent({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.username,
    this.password,
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
      'username': username,
      'password': password,
      'address': address,

      'image': image,
    };
  }
}
