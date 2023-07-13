import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semsark/Repo/home_services.dart';
import 'package:semsark/Repo/location_services.dart';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/request/ad_model.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';
import 'package:semsark/utils/constants.dart';

import '../Repo/remote/firebase_services.dart';
import '../models/response/user_details.dart';

class CreateAdvertisementProvider with ChangeNotifier{

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  // att
  bool isConfirmed = true;
  bool isLoading = false;
  bool success = false;

  HomeServices services = HomeServices();
  String errorMsg="";

  //model att
  List<String> photoList = [];
  var fin_value = "NO" , elevator = "NO" , acceptBusiness = "NO" , acceptSingle = "NO";
  var num_of_rooms = 1,
      num_of_bath_rooms = 1,
      num_of_halls = 1,
      num_of_level = 1;
  var type_val = "APARTMENT";
  var dailyPrice = "MONTHLY";
  var signal_val = "Vodafone";
  var city = "";
  var gov = "Cairo";
  var types = ["APARTMENT", "DUPLEX", "STUDIO"];
  var signals = ["Vodafone", "Orange", "Etisalat", "WE"];
  List<bool> isSelected = [true, false]; // Initialize the selection state of buttons

  List<XFile> photos = [];
  late Position currentPosition;
  Map<String , List<String>> governors = {
    'Cairo': ['Nasr City' ,'Madinty', 'Tagamo3', '3abaseya' , 'Sheraton' , 'Salam'],
    'Giza' : ['Faisal','Haram' , 'Dokki' , 'October' , 'Zaied City'],
    'Alexandria': ['Miami' , 'Ma3mora' , 'Borj El 3arab'],
    'Gharbia' : ['Tanta' , 'Ma7ala' ,'Santa'],
    'Matrouh' : ['3alm El room' , 'Alex St'],
    'Port Said': [],
    'Suez' : [],
    'Luxor' : [],
    'Aswan' : [],
    'Red Sea' : [],
    'South Sinai' : [],
    'Beheira' : [],
    'Ismailia' : [],
    'Minya' : [],
    'Qalyubia' : [],
    'Fayoum' : [],
    'Beni Suef' : [],
    'Sharqia' : [],
    'Asyut' : [],
    'Dakahlia' : [],
    'Kafr El Sheikh' : [],
    'Damietta' : [],
    'New Valley' : [],
    'Qena' : [],
    'Sohag' : [],
    'Monufia' : [],
    'North Sinai' : [],
    'Assiut' : [],
    'Menofia' : [],
    'El Wadi El Gedid' : [],
    'Kafr El Sheikh' : [],
    'Qena' : [],
    'Aswan' : [],
    'Beni Suef' : [],
    'North Sinai' : [],
    'Sharqia' : [],
    'Qalyubia' : [],
    'Ismailia' : [],
    'Damietta' : [],
    'Suez' : [],
    'Monufia' : [],
    'Dakahlia' : [],
    'Faiyum' : [],
    'El Beheira' : [],
    'Sohag' : [],
    'Asyut' : [],
    'Red Sea' : [],
    'Luxor' : [],
    'Minya' : [],
  };
  //UserDetails? userModel;
  init() async {
    setLoading(true);
    currentPosition = await LocationServices().getCurrentPosition();
    // var response = await services.getUser();
    // if(response is Success) {
    //   userModel = response.response as UserDetails;
    //   isVerified = true ;
    //   notifyListeners();
    // }
    setLoading(false);
  }
  CreateAdvertisementProvider(){
    init();
  }

  reset(){
    photoList = [];
    fin_value = "NO" ;
    elevator = "NO" ;
    acceptBusiness = "NO" ;
    acceptSingle = "NO";
    num_of_rooms = 1;
    num_of_bath_rooms = 1;
    num_of_halls = 1;
    num_of_level = 1;
    type_val = "APARTMENT";
    dailyPrice = "MONTHLY";
    signal_val = "Vodafone";
    city = "";
    gov = "Cairo";

    titleController.text = "" ;
    detailsController.text = "" ;
    priceController.text = "" ;
    areaController.text = "" ;
    notifyListeners();
  }
  setElevator(val){
    elevator = val;
    notifyListeners();
  }
  setAcceptBusiness(val){
    acceptBusiness = val;
    notifyListeners();
  }
  setGov(val){
    gov = val;
    notifyListeners();
  }
  setCity(val){
    city = val;
    notifyListeners();
  }
  setAcceptSingle(val){
    acceptSingle = val;
    notifyListeners();
  }
  setType(val){
    type_val = val;
    notifyListeners();
  }
  setSignalPower(val){
    signal_val = val;
    notifyListeners();
  }

  setFinished(finish){
    fin_value = finish;
    notifyListeners();
  }

  setNumOfRooms(num){
    num_of_rooms = num;
    notifyListeners();
  }
  setNumOfBathRooms(num){
    num_of_bath_rooms = num;
    notifyListeners();
  }
  setNumOfHalls(num){
    num_of_halls = num;
    notifyListeners();
  }
  setHouseLevel(num){
    num_of_level = num;
    notifyListeners();
  }

  setDailyPrice(num){
    dailyPrice = num;
    notifyListeners();
  }
  setLoading(load){
    isLoading = load;
    notifyListeners();
  }

  Future uploadPhoto(XFile element) async {
    final FirebaseServices firebaseServices = FirebaseServices();
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    await firebaseServices.upload_image(File(element.path), APP_NAME, "$currentTime") ;
    var path = await firebaseServices.get_url(APP_NAME, "$currentTime");
    return path;
  }

  //Api
  createAdvertisement() async {
    setLoading(true);
    for (int i = 0; i < photos.length; i++) {
      var ppp= await uploadPhoto(photos[i]);
      photoList.add(ppp);
    }
    photos = [] ;
    if(!photoList.isEmpty)
      print(photoList[0]);
    CreateAdvertisementModel model = CreateAdvertisementModel(
        photosList: photoList,
        signalPower: signal_val,
        elevator: elevator=="YES",
        acceptBusiness: acceptBusiness == "YES",
        dailyPrice: dailyPrice,
        title: titleController.text,
        category: isSelected[0] ? "RENT" : "SELL",
        apartmentDetails: detailsController.text,
        city: city,
        gov: gov,
        price: double.parse(priceController.text),
        lng: currentPosition.longitude,
        lat: currentPosition.latitude,
        area: int.parse(areaController.text),
        numOfRoom: num_of_rooms,
        numOfBathroom: num_of_bath_rooms,
        numOfHalls: num_of_halls,
        level: num_of_level,
        finished: fin_value=="YES",
        single: acceptSingle == "YES",
        types: type_val
    );

    var response = await services.createAdvertisement(model);
    setLoading(false);

    if(response is Success){
      success = true ;
      notifyListeners() ;
      reset();
    }else if (response is Failure){
      print(response);
      errorMsg = response.errorResponse as String;
    }
  }

}