// To parse this JSON data, do
//
//     final registerationModel = registerationModelFromJson(jsonString);

import 'dart:convert';

List<ChatUsers> ChatUsersFromJson(String str)=> List<ChatUsers>.from(json.decode(str).map((x) => ChatUsers.fromJson(x)));
String ChatUsersToJson(ChatUsers data) => json.encode(data.toJson());

class ChatUsers {
    int id;
    String email;
    String username;
    String image;

    ChatUsers({
        required this.id,
        required this.email,
        required this.username,
        required this.image,
    });

    factory ChatUsers.fromJson(Map<String, dynamic> json) => ChatUsers(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        image: json["image"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "image": image,
    };
}
