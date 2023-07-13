// To parse this JSON data, do
//
//     final advertisementModel = advertisementModelFromJson(jsonString);

import 'dart:convert';

List<AdvertisementModel> allAdvertisementFromJson(String str) => List<AdvertisementModel>.from(json.decode(str).map((x) => AdvertisementModel.fromJson(x)));
AdvertisementModel advertisementModelFromJson(String str) => AdvertisementModel.fromJson(jsonDecode(str));

String advertisementModelToJson(List<AdvertisementModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvertisementModel {
  int id;
  User user;
  List<String> photosList;
  String signalPower;
  bool elevator;
  bool acceptBusiness;
  String dailyPrice;
  String title;
  String category;
  String apartmentDetails;
  String city;
  String gov;
  String types;
  double price;
  int views;
  DateTime date;
  double lng;
  double lat;
  int area;
  int numOfRoom;
  int numOfBathroom;
  int numOfHalls;
  int level;
  bool finished;
  bool single;

  AdvertisementModel({
    required this.id,
    required this.user,
    required this.photosList,
    required this.signalPower,
    required this.elevator,
    required this.acceptBusiness,
    required this.dailyPrice,
    required this.title,
    required this.category,
    required this.apartmentDetails,
    required this.city,
    required this.gov,
    required this.types,
    required this.price,
    required this.views,
    required this.date,
    required this.lng,
    required this.lat,
    required this.area,
    required this.numOfRoom,
    required this.numOfBathroom,
    required this.numOfHalls,
    required this.level,
    required this.finished,
    required this.single,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
    id: json["id"],
    user: User.fromJson(json["user"]),
    photosList: List<String>.from(json["photosList"].map((x) => x)),
    signalPower: json["signalPower"],
    elevator: json["elevator"],
    acceptBusiness: json["acceptBusiness"],
    dailyPrice: json["dailyPrice"],
    title: json["title"],
    category: json["category"],
    apartmentDetails: json["apartmentDetails"],
    city: json["city"],
    gov: json["gov"],
    types: json["types"],
    price: json["price"],
    views: json["views"],
    date: DateTime.parse(json["date"]),
    lng: json["lng"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
    area: json["area"],
    numOfRoom: json["numOfRoom"],
    numOfBathroom: json["numOfBathroom"],
    numOfHalls: json["numOfHalls"],
    level: json["level"],
    finished: json["finished"],
    single: json["single"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "photosList": List<dynamic>.from(photosList.map((x) => x)),
    "signalPower": signalPower,
    "elevator": elevator,
    "acceptBusiness": acceptBusiness,
    "dailyPrice": dailyPrice,
    "title": title,
    "category": category,
    "apartmentDetails": apartmentDetails,
    "city": city,
    "gov": gov,
    "types": types,
    "price": price,
    "views": views,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "lng": lng,
    "lat": lat,
    "area": area,
    "numOfRoom": numOfRoom,
    "numOfBathroom": numOfBathroom,
    "numOfHalls": numOfHalls,
    "level": level,
    "finished": finished,
    "single": single,
  };
}

class User {
  int userId;
  String? username;
  String? gender;
  String email;
  String? phone;
  String? img;
  String? personalImg;
  String? idImg;
  bool verifyId;
  bool suspended;
  double rate;

  User({
    required this.userId,
    this.username,
    this.gender,
    required this.email,
    this.phone,
    this.img,
    this.personalImg,
    this.idImg,
    required this.verifyId,
    required this.suspended,
    required this.rate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    username: json["username"],
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    img: json["img"],
    personalImg: json["personalImg"],
    idImg: json["idImg"],
    verifyId: json["verifyID"],
    suspended: json["suspended"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "gender": gender,
    "email": email,
    "phone": phone,
    "img": img,
    "personalImg": personalImg,
    "idImg": idImg,
    "verifyID": verifyId,
    "suspended": suspended,
    "rate": rate,
  };
}
