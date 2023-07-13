// To parse this JSON data, do
//
//     final registerationModel = registerationModelFromJson(jsonString);

import 'dart:convert';

ChatMessage ChatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));

String ChatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
    String receiverEmail;
    String message;
    bool status;
    String date;

    ChatMessage({
        required this.receiverEmail,
        required this.message,
        required this.status,
        required this.date,
    });

    factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        receiverEmail: json["receiverEmail"],
        message: json["message"],
        status: json["status"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "receiverEmail": receiverEmail,
        "message": message,
        "status": status,
        "date": date,
    };
}
