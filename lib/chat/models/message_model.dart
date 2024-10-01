class MessageModel {
  String type;
  String message;
  String time;

  MessageModel({required this.type, required this.message, required this.time});

  // Method to convert a MessageModel instance to JSON
  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'time': time,
      };

  // Method to create a MessageModel instance from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      type: json['type'],
      message: json['message'],
      time: json['time'],
    );
  }
}
