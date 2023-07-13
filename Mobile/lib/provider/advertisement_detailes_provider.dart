import 'package:flutter/cupertino.dart';
import 'package:semsark/Repo/home_services.dart';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';

class AdvertisementDetailsProvider with ChangeNotifier{

  bool isLoading = false ;
  bool isFav = false ;
  String errorMsg = "" ;
  HomeServices services = HomeServices();
  AdvertisementModel? model;
  int id = 0 ;
  List<AdvertisementModel> recomended =[];
  changeFav() async {
    if(!isFav){
      await addToFav(id) ;
    }else {
      await removeFromFav(id) ;
    }
    isFav = !isFav ;
    notifyListeners();
  }
  addToFav(id) async {
    await services.addToFav(id) ;
  }
  removeFromFav(id) async {
    await services.removeFromFav(id) ;
  }
  setID(nId) async {
    id = nId ;
    await getAdvertisement(id) ;
    notifyListeners() ;
  }

  setModel(AdvertisementModel model) async {
    this.model = model ;
    id = model.id ;
    var res = await services.checkIsFav(id) ;
    isFav = res == "true";
    var response = await services.getRecommendations(id) ;
    if(response is Success) {
      recomended = response.response as List<AdvertisementModel> ;
      recomended.removeWhere((element) => element.category!=model.category);
    }
    print(recomended);
    notifyListeners() ;
  }

  // AdvertisementDetailsProvider(){
  //   init();
  // }
  // init() async {
  //   setLoading(true) ;
  //   setLoading(false);
  // }

  getRecommended(){
    setLoading(true);

    setLoading(false);
  }
  setLoading(newLoad){
    isLoading = newLoad ;
    notifyListeners() ;
  }

  getAdvertisement(id) async {
    setLoading(true) ;
    var response = await services.getAdvertisementById(id) ;
    if(response is Success) {
      model = response.response as AdvertisementModel ;
    }else if (response is Failure){
      errorMsg = response.errorResponse as String;
    }
    setLoading(false);
    notifyListeners();
  }

}