import 'package:flutter/cupertino.dart';

import '../Repo/remote/auth_services.dart';
import '../Repo/remote/remote_status.dart';
import '../utils/helper.dart';

class ForgetPasswordProvider with ChangeNotifier{
  String? otp;
  String? email;
  String? password;
  bool loading=false;
  AuthServices services = AuthServices();
  bool success=false;
  String? errorMessage;
  bool showTimer = false;
  int timerDuration = 60;
  setLoading(newLoading) {
    loading = newLoading;
    notifyListeners();
  }

  setPassword(password){
    this.password=password;
  }

  setEmail(email){
    this.email=email;
  }

  setOtp(otp){
    this.otp=otp;
  }

  forgetPassword() async {
    success = false;
    setLoading(true);
    var response = await services.forgetPassEmailVerification(email);
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
    await services.forgetPassCheckOtp(email,otp);
    setLoading(false);
    if (response is Success) {
      success = true;
    } else if (response is Failure) {
      errorMessage = response.errorResponse as String?;
    }
  }

  updatePassword(pass) async{
    setLoading(true);
    var response =
    await services.updatePAssword(email,otp, pass);
    setLoading(false);
    if (response is Success) {
      Helper.setToken(response.response as String);
      success = true;
    } else if (response is Failure) {
      errorMessage = response.errorResponse as String?;
    }
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

}