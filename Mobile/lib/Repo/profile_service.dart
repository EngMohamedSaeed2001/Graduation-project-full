import 'dart:convert';
import 'dart:io';

import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';

import '../models/response/user_details.dart';
import '../utils/constants.dart';
import '../utils/end_points.dart';
import 'package:http/http.dart' as http;

import '../utils/helper.dart';


class ProfileServices {
  var headers = {
    'Access-Control-Allow-Headers':
    "DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Authorization",
    'Access-Control-Allow-Origin': "*",
    'Access-Control-Allow-Credentials': "true",
    'content-Type': 'application/json',
    'Accept': "application/json",
  };

  String token = "";

  Future deleteAd(id) async
  {
    token=await Helper.getToken();
    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.delete(
        Uri.parse("${DELETE_ADVERTISEMENT}$id"),
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
      print(e) ;
      return Failure(code: UNKNOWN, errorResponse: e);
    }
  }
  // Future getUser() async {
  //   token=await Helper.getToken();
  //
  //   String url = '$GET_USER';
  //   headers['Authorization'] = 'Bearer $token';
  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(url),
  //       headers: headers,
  //     );
  //     print(response.statusCode);
  //
  //     if (response.statusCode == 200) {
  //       return Success(code: 200, response: userDetailsFromJson(response.body));
  //     }
  //     return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
  //   } on HttpException {
  //     return Failure(code: NO_INTERNE, errorResponse: "No Internet");
  //   } on FormatException {
  //     return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
  //   } catch (e) {
  //     print(e) ;
  //     return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
  //   }
  // }


  Future getUser() async {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.get(
        Uri.parse(GET_USER),
        headers: headers,
      );
      print(response.body);
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

  Future verifyNID(face1 , face2) async
  {
    token=await Helper.getToken();

    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.post(
        Uri.parse(VERIFY_NID),
        headers: headers,
        body: jsonEncode({
          "face1": face1,
          "face2": face2
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(
          code: 200,
          response:jsonDecode(response.body)["result"],
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
  Future getMyAds() async {
    token=await Helper.getToken();

    String url = '$GET_MY_ADS';
    headers['Authorization'] = 'Bearer $token';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {

        return Success(code: 200, response: allAdvertisementFromJson(response.body));
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

  Future getMyFavs() async {
    token=await Helper.getToken();

    String url = '$GET_MY_FAVS';
    headers['Authorization'] = 'Bearer $token';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {

        return Success(code: 200, response: allAdvertisementFromJson(response.body));
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

  Future editUser(UserDetails user) async {
    token=await Helper.getToken();

    String url = '$UPDATE_USER';
    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.patch(Uri.parse(url),
          headers: headers, body: jsonEncode({
            "username": user.username,
            "password": "",
            "phone": user.phone,
            "gender": user.gender,
            "img": user.img
          }));
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: "",
        );
      }
      return Failure(
          code: INVALID_RESPONSE,
          errorResponse: jsonDecode(response.body)["message"]);
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }

  Future logout() async {
    token=await Helper.getToken();

    String url = '$SIGN_OUT';
    headers['Authorization'] = 'Bearer $token';
    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: headers
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: ""
        );
      }
      return Failure(
          code: INVALID_RESPONSE,
          errorResponse: jsonDecode(response.body)["message"]);
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
}
