import 'package:flutter/cupertino.dart';
import 'package:semsark/Repo/remote/auth_services.dart';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/utils/helper.dart';

class LoginProvider with ChangeNotifier {
  // att
  bool loading=false;
  String? errorMessage;
  bool success=false;
  bool showPassword = false;
  String email="";
  String password="";
  AuthServices services = AuthServices();
  setLoading(newLoading) {
    loading = newLoading;
    notifyListeners();
  }

  setShowPassword() {
    showPassword = !showPassword;
    //notifyListeners();
  }

  LoginProvider(){
    setLoading(true);
    // errorMessage="";
    setLoading(false);
  }

  login() async{
    setLoading(true);
    var response =
        await services.login(email, password);
    setLoading(false);
    if (response is Success) {
      await Helper.setToken(response.response as String);
      await Helper.setEmail(email);
      await Helper.setPassword(password);
      notifyListeners();
      success = true;
    } else if (response is Failure) {
      errorMessage = response.errorResponse as String?;
    }
    notifyListeners();
  }
}
