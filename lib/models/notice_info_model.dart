class NoticeInfoModel {
  final DateTime date;
  final String title;
  final String description;
  final List? files;

  NoticeInfoModel({
    required this.date,
    required this.title,
    required this.description,
    this.files,
  });

  factory NoticeInfoModel.fromJson(Map<String, dynamic> json) {
    return NoticeInfoModel(
      date: DateTime.parse(
          json['date']), // Ensure your backend returns a proper date format
      title: json['title'],
      description: json['description'],
      files: json['files'] != null ? List.from(json['files']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'files': files,
    };
  }
}
