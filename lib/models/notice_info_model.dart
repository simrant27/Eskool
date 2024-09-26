class NoticeInfoModel {
  final DateTime? createdAt; // Nullable date
  final String title;
  final String description;
  final String? file; // Keep this as a String, not List<String>
  final String id;

  NoticeInfoModel({
    this.createdAt,
    required this.title,
    required this.description,
    this.file,
    required this.id,
  });

  factory NoticeInfoModel.fromJson(Map<String, dynamic> json) {
    return NoticeInfoModel(
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      file: json['file'], // Directly assign the file as a String
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'title': title,
      'description': description,
      'file': file, // Keep this as a String
      'id': id, // Correctly use the id
    };
  }
}
