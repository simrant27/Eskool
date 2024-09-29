class Parent {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String username;
  final String image;
  final List<dynamic>? children;

  Parent({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.children,
    required this.username,
    this.image = '',
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['_id'],
      children: json['children'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      image: json['image'] ?? '',
    );
  }
}
