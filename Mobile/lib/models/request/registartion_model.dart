// To parse this JSON data, do
//
//     final registerationModel = registerationModelFromJson(jsonString);

import 'dart:convert';

RegisterationModel registerationModelFromJson(String str) => RegisterationModel.fromJson(json.decode(str));

String registerationModelToJson(RegisterationModel data) => json.encode(data.toJson());

class RegisterationModel {
  String username;
  String phone;
  String email;
  bool social;
  String img;
  String password;
  String gender;

  RegisterationModel({
    required this.username,
    required this.phone,
    required this.email,
    required this.social,
    required this.img,
    required this.password,
    required this.gender,
  });

  factory RegisterationModel.fromJson(Map<String, dynamic> json) => RegisterationModel(
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    social: json["social"],
    img: json["img"],
    password: json["password"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "phone": phone,
    "email": email,
    "social": social,
    "img": img,
    "password": password,
    "gender": gender,
  };
}
