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

class EditAdProvider with ChangeNotifier{

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  // att
  bool isLoading = false;
  bool success = false;

  var fin_value = "NO" , elevator = "YES" , acceptBusiness = "YES" , acceptSingle = "YES";
  var num_of_rooms = 1,
      num_of_bath_rooms = 1,
      num_of_halls = 1,
      num_of_level = 1;
  var type_val = "APARTMENT";
  var dailyPrice = "MONTHLY";
  var signal_val = "Vodafone";
  var types = ["APARTMENT", "DUPLEX", "STUDIO"];
  var signals = ["Vodafone", "Orange", "Etisalat", "WE"];
  AdvertisementModel? model;

  HomeServices services = HomeServices();
  String errorMsg="";

  //model att
  Map<String , List<String>> governors = {
    'Cairo': ['Zamalek','Nasr City' ,'Madinty', 'Tagamo3', '3abaseya' , 'Sheraton' , 'Salam'],
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

  setModel(_model){
    model = _model ;
    titleController.text= model!.title ;
    priceController.text= model!.price.toString() ;
    areaController.text= model!.area.toString() ;
    detailsController.text= model!.apartmentDetails ;

    dailyPrice = model!.dailyPrice ;
    signal_val = model!.signalPower ;
    type_val = model!.types ;
    num_of_level = model!.level ;
    num_of_halls = model!.numOfHalls ;
    num_of_bath_rooms = model!.numOfBathroom ;
    num_of_rooms = model!.numOfRoom ;

    fin_value = model!.finished ? "YES" : "NO" ;
    acceptBusiness = model!.acceptBusiness ? "YES" : "NO" ;
    acceptSingle = model!.single ? "YES" : "NO" ;
    elevator = model!.elevator ? "YES" : "NO" ;
    notifyListeners() ;
  }
  setElevator(val){
    elevator = val;
    notifyListeners();
  }
  setAcceptBusiness(val){
    acceptBusiness = val;
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
    isLoading = load ;
    notifyListeners() ;
  }
  editAdvertisement() async {
    setLoading(true);
    model!.title = titleController.text ;
    model!.price = double.parse(priceController.text);
    model!.area = int.parse(areaController.text);
    model!.dailyPrice = dailyPrice;

    model!.apartmentDetails = detailsController.text;
    model!.types = type_val;
    model!.signalPower = signal_val;

    model!.numOfRoom = num_of_rooms ;
    model!.numOfBathroom = num_of_bath_rooms ;
    model!.level = num_of_level ;
    model!.numOfHalls = num_of_halls ;

    model!.single = acceptSingle=="YES" ;
    model!.finished = fin_value=="YES" ;
    model!.acceptBusiness = acceptBusiness=="YES" ;
    model!.elevator = elevator=="YES" ;


    var response = await services.editAdvertisement(model!);
    setLoading(false);

    if(response is Success){
      success = true ;
      notifyListeners() ;
    }else if (response is Failure){
      print(response);
      errorMsg = response.errorResponse as String;
    }
  }
}