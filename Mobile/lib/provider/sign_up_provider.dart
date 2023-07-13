import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:hive/hive.dart';
import 'package:semsark/Repo/remote/auth_services.dart';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/request/registartion_model.dart';

import '../Repo/remote/firebase_services.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';

class SignUpProvider with ChangeNotifier {
  // att
  XFile? image;
  bool edit=true;
  bool loading=false;
  String? errorMessage;
  bool success=false;
  bool showPassword = false;
  String? email;
  String? name;
  String? otp;
  String? phoneNumber;
  String? gender;
  String? password;
  bool showTimer = false;
  int timerDuration = 60;
  String imagePath="";
  AuthServices services = AuthServices();
  setImage(image){
    this.image=image;
    notifyListeners();
  }
  setLoading(newLoading) {
    loading = newLoading;
    notifyListeners();
  }
  setEdit(){
    edit=!edit;
    notifyListeners();
  }

  setEmail(email){
    this.email=email;
    notifyListeners();
  }
  setName(name){
    this.name=name;
    notifyListeners();
  }
  setPhoneNumber(phoneNumber){
    this.phoneNumber=phoneNumber;
    notifyListeners();
  }
  setGender(gender){
    this.gender=gender;
    notifyListeners();
  }
  setPassword(password){
    this.password=password;
    notifyListeners();
  }
  setOtp(otp){
    this.otp=otp;
    notifyListeners();
  }
  setShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  verifyEmail() async {
    success = false;
    setLoading(true);
    var response = await services.verifyEmail(email);
    setLoading(false);
    if (response is Success) {
      sendOtp();
      success = true;
    } else if (response is Failure) {
      errorMessage = response.errorResponse as String?;
    }
    notifyListeners();
  }
  setShowTime(timer){
    showTimer=timer;
    notifyListeners();
  }
  Future<void> startTimer() async {
    setShowTime(true);
    timerDuration = 60;
    notifyListeners();
    for (int i=0; i<60; i++){
      await Future.delayed(Duration(seconds: 1));
      timerDuration--;
      notifyListeners();
    }
    setShowTime(false);
  }

  sendOtp() async {
    success = false;

    setLoading(true);
      var response = await services.sendOtp(email);
      setLoading(false);
      if (response is Success) {
        success = true;
      } else if (response is Failure) {
        errorMessage = response.errorResponse as String?;
      }

  }

  verifyOtp() async {
    success = false;

    setLoading(true);
    var response =
    await services.verifyOtp(email,otp);
    setLoading(false);
    if (response is Success) {
      success = true;
    } else if (response is Failure) {
      errorMessage = response.errorResponse as String?;
    }
    notifyListeners();
  }

  Future<bool> createUser() async {
    setLoading(true);
    if (image!=null){
      await uploadPhoto(image!);
    }
    var response =
    await services.createUser(RegisterationModel(username: name!, phone: phoneNumber!, email: email!, social: false, img: imagePath,   password: password!, gender: gender!));
    setLoading(false);
    if (response is Success) {
      await Helper.setToken(response.response as String);
      await Helper.setEmail(email);
      await Helper.setPassword(password);
      notifyListeners();
      return true;
    } else if (response is Failure) {
      errorMessage = response.errorResponse as String?;
    }
    return false;
  }

  Future uploadPhoto(XFile element) async {
    final FirebaseServices firebaseServices = FirebaseServices();
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    await firebaseServices
        .upload_image(File(element.path), "$APP_NAME/personalImage", "$currentTime")
        .then((value) async {
      await firebaseServices.get_url("$APP_NAME/personalImage", "$currentTime").then((path) {
        imagePath=path;
      });
    });
    notifyListeners();
  }
}
