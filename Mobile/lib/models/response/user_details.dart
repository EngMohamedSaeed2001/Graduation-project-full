// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:semsark/models/response/advertisement_response_model.dart';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());
Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class UserDetails {

  int id;
  String? username;
  String? gender;
  String email;
  String? password;
  String? phone;
  double? rate;
  double? rateSum;
  int? rateCounter;
  Profile? profile;
  bool? verifyId;
  bool? verify;
  bool? suspended;
  String ?deviceId;
  String ?img;
  String ?personalImg;
  String ?idImg;
  Favourites? favourites;

  UserDetails({
    required this.id,
    this.username,
    this.gender,
    required this.email,
    this.password,
    this.phone,
    this.rate,
    this.rateSum,
    this.rateCounter,
    this.profile,
    this.verifyId,
    this.verify,
    this.suspended,
    this.deviceId,
    this.img,
    this.personalImg,
    this.idImg,
    this.favourites,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    username: json["username"],
    gender: json["gender"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    rate: json["rate"],
    rateSum: json["rateSum"],
    rateCounter: json["rateCounter"],
    profile: Profile.fromJson(json["profile"]),
    verifyId: json["verifyID"],
    verify: json["verify"],
    suspended: json["suspended"],
    deviceId: json["deviceId"],
    img: json["img"],
    personalImg: json["personalImg"],
    idImg: json["idImg"],
    favourites:json["favourites"]==null ? null : Favourites.fromJson(json["favourites"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "gender": gender,
    "email": email,
    "password": password,
    "phone": phone,
    "rate": rate,
    "rateSum": rateSum,
    "rateCounter": rateCounter,
    "profile": profile==null ? null : profile!.toJson(),
    "verifyID": verifyId,
    "verify": verify,
    "suspended": suspended,
    "deviceId": deviceId,
    "img": img,
    "personalImg": personalImg,
    "idImg": idImg,
    "favourites": favourites==null ? null : favourites!.toJson(),
  };
}

class Favourites {
  int id;
  int userId;
  List<AdvertisementModel> buildings;

  Favourites({
    required this.id,
    required this.userId,
    required this.buildings,
  });

  factory Favourites.fromJson(Map<String, dynamic> json) => Favourites(
    id: json["id"],
    userId: json["userId"],
    buildings: List<AdvertisementModel>.from(json["buildings"].map((x) => AdvertisementModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "buildings": List<dynamic>.from(buildings.map((x) => x.toJson())),
  };
}


class Profile {
  int id;
  String name;
  List<Role> roles;

  Profile({
    required this.id,
    required this.name,
    required this.roles,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  int id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
