import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';
import 'package:semsark/models/response/user_details.dart';
import '../../models/request/ad_model.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;
import '../../utils/end_points.dart';
import '../utils/helper.dart';

class HomeServices {

  var headers = {
    'Access-Control-Allow-Headers':
    "DNT,X-CustomHeader,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Authorization",
    'Access-Control-Allow-Origin': "*",
    'Access-Control-Allow-Credentials': "true",
    'content-Type': 'application/json',
    'Accept': "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };


  Future checkIsFav(id) async {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.get(
        Uri.parse("$CHECK_IS_FAV$id"),
        headers: headers,
      );
      return response.body ;
    } catch (e) {
      return false ;
    }
  }
  Future refreshToken() async {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';

  final http.Response response = await http.get(
  Uri.parse("$baseURL/token/refresh"),
  headers: headers,
  );
  return jsonDecode(response.body)["refreshToken"] ;
}
  Future addToFav(id) async
  {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';

    try {
      final http.Response response = await http.post(
        Uri.parse("$ADD_TO_FAV/$id"),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 302) {
        return Success(
          code: 200,
          response:"",
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "401");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: FormatException);
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: e);
    }
  }
  Future removeFromFav(id) async
  {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';
    print(token);
    try {
      final http.Response response = await http.delete(
        Uri.parse("${DELETE_FROM_FAV}$id"),
        headers: headers,
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response:"",
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: jsonDecode(response.body)["message"]);
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: FormatException);
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: e);
    }
  }

  String token = "";
  Future createAdvertisement(CreateAdvertisementModel model) async
  {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';

    try {
      final http.Response response = await http.post(
          Uri.parse(CREATE_AD),
          headers: headers,
          body: createAdvertisementModelToJson(model)
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(
          code: 200,
          response:"",
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: jsonDecode(response.body)["message"]);
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: FormatException);
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: e);
    }
  }

  Future editAdvertisement(AdvertisementModel model) async
  {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';

    try {
      final http.Response response = await http.patch(
          Uri.parse("$EDIT_AD/${model.id}"),
          headers: headers,
          body: jsonEncode(model.toJson())
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response:"",
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: jsonDecode(response.body)["message"]);
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: FormatException);
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: e);
    }
  }

  // Future getUser() async {
  //   token=await Helper.getToken();
  //
  //   headers['Authorization'] = 'Bearer $token';
  //   try {
  //     final http.Response response = await http.get(
  //       Uri.parse(GET_USER),
  //       headers: headers,
  //     );
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       return Success(
  //         code: 200,
  //         response: userDetailsFromJson(response.body),
  //       );
  //     }
  //     return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
  //   } on HttpException {
  //     return Failure(code: NO_INTERNE, errorResponse: "No Internet");
  //   } on FormatException {
  //     return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
  //   } catch (e) {
  //     print(e);
  //     return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
  //   }
  // }
  Future createFakeAds()async{

    Random random = Random();
    List<double> lat=[30.045012, 30.031740,30.037960,30.037980,30.045005, 30.038000,30.037840,30.047220, 30.037900,30.031780];
    List<double> lng=[31.205260,31.211251,31.210968,31.215250,31.211241,31.212978,31.205260,31.211241,31.211948,31.205260];
    for (int i = 0; i < 10; i++) {
      CreateAdvertisementModel ad = CreateAdvertisementModel(
        signalPower: random.nextBool() ? SignalPower.Vodafone.name : SignalPower.WE.name,
        elevator: random.nextBool(),
        acceptBusiness: random.nextBool(),
        dailyPrice: random.nextBool() ? DailyPrice.DAILY.name : DailyPrice.MONTHLY.name,
        title: "Fake Ad #${i + 1}",
        category: random.nextBool() ? Category.SELL.name : Category.RENT.name,
        apartmentDetails: "Spacious and modern apartment",
        city: "Giza",
        gov: "Dokki",
        price: random.nextInt(10000000).toDouble(),
        lng: lng[i], // Giza, Dokki longitude range
        lat: lat[i], // Giza, Dokki latitude range
        area: 100,
        numOfRoom: random.nextInt(4) + 1,
        numOfBathroom: random.nextInt(3) + 1,
        numOfHalls: random.nextInt(2) + 1,
        level: random.nextInt(10) + 1,
        finished: random.nextBool(),
        single: random.nextBool(),
        types: random.nextBool() ? Types.APARTMENT.name : Types.DUPLEX.name,
        photosList: ["https://firebasestorage.googleapis.com/v0/b/gp-semsark.appspot.com/o/haha.jpeg?alt=media&token=bba90df7-0c46-4edd-ade2-0f1ddc8aa307"],
      );
      await createAdvertisement(ad);
      print("ad $i created");
    }
  }

   double generateRandomCoordinate(double min, double max) {
    Random random = Random();
    return min + (max - min) * random.nextDouble();
  }
  Future getUserById(id) async {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.get(
        Uri.parse('${GET_USER}/${id}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: userDetailsFromJson(response.body),
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }

  Future getAdvertisements() async {
    token=await Helper.getToken();

    try {
      final http.Response response = await http.get(
        Uri.parse(GET_ALL_ADS),
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: allAdvertisementFromJson(response.body),
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e) ;
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
  Future getRecommendations(id) async {
    token=await Helper.getToken();

    try {
      final http.Response response = await http.post(
        Uri.parse("$GET_RECOMMENDED_ADS$id"),
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: allAdvertisementFromJson(response.body),
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e) ;
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
  Future getAdvertisementById( id ) async {
    token=await Helper.getToken();

    // String token = await getToken();
    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.get(
        Uri.parse("$GET_AD_BY_ID/$id"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: advertisementModelFromJson(response.body),
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e) ;
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
  Future filter(data) async {
    token=await Helper.getToken();

    // String token = await getToken();
    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.post(
          Uri.parse("$FILTER"),
          headers: headers,
          body: jsonEncode(data)
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response:  allAdvertisementFromJson(response.body),
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e) ;
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
}