class Result {
  final String subject;
  final double marks;

  Result({required this.subject, required this.marks});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      subject: json['subject'],
      marks: json['marks'],
    );
  }
}
