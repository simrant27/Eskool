class Material {
  final String id;
  final String title;
  final String description;
  final String? file; // Just the file name from the response
  final DateTime uploadedAt;

  Material({
    required this.id,
    required this.title,
    required this.description,
    required this.file,
    required this.uploadedAt,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      file: json['file'], // This will be just the file name
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }

  // This method constructs the full URL to the file
  String getFileUrl(String baseUrl) {
    return '$baseUrl/assets/$file'; // Assuming 'assets' is the path to files on your server
  }
}
