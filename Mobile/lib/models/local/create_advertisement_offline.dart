import 'dart:core';
import 'dart:io';

class LocalAdvertisement {
  List<File> photosList;
  String signalPower;
  String title;
  String category; // rent or sell
  String dailyPrice; // daily - monthly - yearly
  String address;
  String des;
  String apartmentDetails;
  String city; //
  String gov;
  String types; // duplex - apartment - villa
  double price; // min price - max price
  double lng;
  double lat;
  int area; // min - max
  int numOfRoom; // min - max
  int numOfBathroom; // min - max
  int numOfHalls; // min - max
  int level;
  bool finished; // yes - no
  bool single; // yes - no
  bool acceptBusiness; // yes - no
  bool elevator;

  LocalAdvertisement(
      this.photosList,
      this.signalPower,
      this.title,
      this.category,
      this.dailyPrice,
      this.address,
      this.des,
      this.apartmentDetails,
      this.city,
      this.gov,
      this.types,
      this.price,
      this.lng,
      this.lat,
      this.area,
      this.numOfRoom,
      this.numOfBathroom,
      this.numOfHalls,
      this.level,
      this.finished,
      this.single,
      this.acceptBusiness,
      this.elevator);
}
