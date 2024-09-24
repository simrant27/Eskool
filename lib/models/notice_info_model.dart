class NoticeInfoModel {
  final DateTime? createdAt; // Nullable date
  final String title;
  final String description;
  final List<String>? files;
  final String id; // Specify the type of files as List<String>

  NoticeInfoModel(
      {this.createdAt,
      required this.title,
      required this.description,
      this.files,
      required this.id});

  factory NoticeInfoModel.fromJson(Map<String, dynamic> json) {
    return NoticeInfoModel(
        createdAt: DateTime.parse(json['createdAt']),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        files: json['files'] != null
            ? List<String>.from(json['files']) // Ensure type consistency
            : null,
        id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'title': title,
      'description': description,
      'files': files,
      'id': 'id'
    };
  }
}
