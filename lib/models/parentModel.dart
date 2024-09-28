class Parent {
  String? id;
  String fullName;
  String email;
  String phone;
  String address;
  List<String>? children;
  String username;
  String password;
  String image;

  Parent({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.children,
    required this.username,
    required this.password,
    this.image = '',
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      children: List<String>.from(json['children']) ?? [],
      username: json['username'],
      password: json['password'],
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'children': children,
      'username': username,
      'password': password,
      'image': image,
    };
  }
}
