// To parse this JSON data, do
//
//     final createAdvertisementModel = createAdvertisementModelFromJson(jsonString);

import 'dart:convert';

CreateAdvertisementModel createAdvertisementModelFromJson(String str) => CreateAdvertisementModel.fromJson(json.decode(str));

String createAdvertisementModelToJson(CreateAdvertisementModel data) => json.encode(data.toJson());

class CreateAdvertisementModel {
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
  double price;
  double lng;
  double lat;
  int area;
  int numOfRoom;
  int numOfBathroom;
  int numOfHalls;
  int level;
  bool finished;
  bool single;
  String types;

  CreateAdvertisementModel({
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
    required this.price,
    required this.lng,
    required this.lat,
    required this.area,
    required this.numOfRoom,
    required this.numOfBathroom,
    required this.numOfHalls,
    required this.level,
    required this.finished,
    required this.single,
    required this.types,
  });

  factory CreateAdvertisementModel.fromJson(Map<String, dynamic> json) => CreateAdvertisementModel(
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
    price: json["price"],
    lng: json["lng"],
    lat: json["lat"],
    area: json["area"],
    numOfRoom: json["numOfRoom"],
    numOfBathroom: json["numOfBathroom"],
    numOfHalls: json["numOfHalls"],
    level: json["level"],
    finished: json["finished"],
    single: json["single"],
    types: json["types"],
  );

  Map<String, dynamic> toJson() => {
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
    "price": price,
    "lng": lng,
    "lat": lat,
    "area": area,
    "numOfRoom": numOfRoom,
    "numOfBathroom": numOfBathroom,
    "numOfHalls": numOfHalls,
    "level": level,
    "finished": finished,
    "single": single,
    "types": types,
  };
}
