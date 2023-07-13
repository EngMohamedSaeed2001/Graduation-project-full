// To parse this JSON data, do
//
//     final filterModelRequest = filterModelRequestFromJson(jsonString);

import 'dart:convert';

FilterModelRequest filterModelRequestFromJson(String str) => FilterModelRequest.fromJson(json.decode(str));

String filterModelRequestToJson(FilterModelRequest data) => json.encode(data.toJson());

class FilterModelRequest {
  String category;
  String city;
  List<String> types;
  int minPrice;
  int maxPrice;
  int minArea;
  int maxArea;
  int minNumOfRoom;
  int maxNumOfRoom;
  int minNumOfBathroom;
  int maxNumOfBathroom;
  int minNumOfHalls;
  int maxNumOfHalls;
  bool finished;
  bool single;
  bool acceptBusiness;

  FilterModelRequest({
    required this.category,
    required this.city,
    required this.types,
    required this.minPrice,
    required this.maxPrice,
    required this.minArea,
    required this.maxArea,
    required this.minNumOfRoom,
    required this.maxNumOfRoom,
    required this.minNumOfBathroom,
    required this.maxNumOfBathroom,
    required this.minNumOfHalls,
    required this.maxNumOfHalls,
    required this.finished,
    required this.single,
    required this.acceptBusiness,
  });

  factory FilterModelRequest.fromJson(Map<String, dynamic> json) => FilterModelRequest(
    category: json["category"],
    city: json["city"],
    types: List<String>.from(json["types"].map((x) => x)),
    minPrice: json["minPrice"],
    maxPrice: json["maxPrice"],
    minArea: json["minArea"],
    maxArea: json["maxArea"],
    minNumOfRoom: json["minNumOfRoom"],
    maxNumOfRoom: json["maxNumOfRoom"],
    minNumOfBathroom: json["minNumOfBathroom"],
    maxNumOfBathroom: json["maxNumOfBathroom"],
    minNumOfHalls: json["minNumOfHalls"],
    maxNumOfHalls: json["maxNumOfHalls"],
    finished: json["finished"],
    single: json["single"],
    acceptBusiness: json["acceptBusiness"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "city": city,
    "types": List<dynamic>.from(types.map((x) => x)),
    "minPrice": minPrice,
    "maxPrice": maxPrice,
    "minArea": minArea,
    "maxArea": maxArea,
    "minNumOfRoom": minNumOfRoom,
    "maxNumOfRoom": maxNumOfRoom,
    "minNumOfBathroom": minNumOfBathroom,
    "maxNumOfBathroom": maxNumOfBathroom,
    "minNumOfHalls": minNumOfHalls,
    "maxNumOfHalls": maxNumOfHalls,
    "finished": finished,
    "single": single,
    "acceptBusiness": acceptBusiness,
  };
}
