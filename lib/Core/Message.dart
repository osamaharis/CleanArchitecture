class GMessage {
  GMessage({required this.message});

  String? message;

  factory GMessage.fromJson(Map<String, dynamic> json) => GMessage(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
