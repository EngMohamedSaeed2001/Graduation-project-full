import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semsark/Repo/profile_service.dart';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/response/user_details.dart';
import '../Repo/remote/firebase_services.dart';
import '../models/response/advertisement_response_model.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';

class ProfileProvider with ChangeNotifier {

  List<AdvertisementModel> myAds = [];
  List<AdvertisementModel> fav = [];
  UserDetails user = UserDetails(id: 1, email: 'email.@email.com',);
  XFile? image ;
  final TextEditingController controller = TextEditingController();
  final TextEditingController usernameContoller = TextEditingController();
  XFile? userImage;
  XFile? NidImage;
  String errorMsg= "";
  bool loading = false;
  ProfileServices services = ProfileServices();
  bool showPassword = false;
  bool success = true;
  bool adClick = true;

  init() async {
    setLoading(true);
    await getUser();
    await getMyAds();
    await getMyFavourits();
    controller.text=user.phone==null? "" :user.phone!.substring(3);
    usernameContoller.text=user.username??"";
    setLoading(false);

  }

  ProfileProvider() {
    init();
  }
  Future<void> getUser() async {
    setLoading(true);
    var response = await services.getUser();
    print(response);
    if (response is Success) {
      user = response.response as UserDetails;
    }
    setLoading(false);

    notifyListeners();
  }

  Future<void> getMyAds() async {
    setLoading(true);
    var response = await services.getMyAds();

    if (response is Success) {

      myAds = response.response as List<AdvertisementModel>;

      setLoading(false);

    }
    notifyListeners();
  }

  Future<void> getMyFavourits() async {
    //setLoading(true);
    var response = await services.getMyFavs();

    if (response is Success) {

      fav = response.response as List<AdvertisementModel>;


    }
    //setLoading(false);
    notifyListeners();
  }
  Future<void> editProfile() async {
    setLoading(true);
    user.phone="+20${controller.text}";
    user.username=usernameContoller.text;
      if (image!=null){
        user.img=await uploadPhoto(image!);
      }
    var response = await services.editUser(user);
    if (response is Success) {
      success=true;
    }
    setLoading(false);
    notifyListeners();
  }

  Future<void> logout() async {
    setLoading(true);
    var response = await services.logout();
    if (response is Success) {
      await Helper.setToken("");
      await Helper.setEmail("");
      await Helper.setPassword("");
    }
    setLoading(false);
    notifyListeners();
  }

  Future uploadPhoto(XFile element) async {
    final FirebaseServices firebaseServices = FirebaseServices();
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    await firebaseServices.upload_image(File(element.path), APP_NAME, "$currentTime") ;
    var path = await firebaseServices.get_url(APP_NAME, "$currentTime");
    return path;
  }

  verify() async {
    setLoading(true) ;
    success = false ;
    if(userImage!=null && NidImage != null){
      var path1 = await uploadPhoto(userImage!) ;
      var path2 = await uploadPhoto(NidImage!) ;
      var response =await services.verifyNID(path1 , path2) ;
      print(response) ;
      if(response is Success){
        print(response.response) ;
        userImage = null ;
        NidImage = null ;
        if(response.response == true){
          success = true ;
        }else {
          errorMsg = "The 2 faces are not matching,\n Please upload a clear Images" ;
        }

      }else if(response is Failure){
        errorMsg = response.errorResponse as String;
      }
    }
    else {
      errorMsg = "Please Add Photos";
    }
    setLoading(false) ;
  }

  Future<void> takeUserPhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      userImage = pickedFile ;
      notifyListeners();
    }
  }
  Future<void> takeNIdPhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      NidImage = pickedFile ;
      notifyListeners();
    }
  }


  deleteAd(id) async{
    setLoading(true) ;
    var response = await services.deleteAd(id);
    if(response is Success) {
      await getMyAds() ;
    }
    setLoading(false) ;
  }
  setShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  setImage(_image){
    image = _image ;
    notifyListeners();
  }

  void setLoading(loading) {
    this.loading = loading;
    notifyListeners();
  }

  void setSuccess(loading) {
    this.success = loading;
    notifyListeners();
  }

  setAd(clk) async {
    adClick = clk;
    await getMyFavourits();
    notifyListeners();

  }
}
