import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/request/registartion_model.dart';
import '../../utils/constants.dart';
import '../../utils/end_points.dart';

class AuthServices {
  var headers = {
    'Access-Control-Allow-Headers':
        "DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Authorization",
    'Access-Control-Allow-Origin': "*",
    'Access-Control-Allow-Credentials': "true",
    'content-Type': 'application/json',
    'Accept': "application/json"
  };


  // Future<bool> checkOtp(String email, String OTP) async {
  //   dynamic data = await Api().post(
  //       url: 'forgetPassword/checkOtp',
  //       body: jsonEncode({"otp": OTP, "email": email}));
  //   return true;
  // }
  //
  // Future<bool> updatePassword(String email, String password, String OTP) async {
  //   dynamic data = await Api().post(
  //       url: 'forgetPassword/updatePassword',
  //       body: jsonEncode({"email": email, "password": password, "otp": OTP}));
  //   return true;
  // }
  //
  // Future<bool> verifyEmail(String email) async {
  //   dynamic data =
  //       await Api().get(url: 'insecure/userDetails/checkEmail/' + email);
  //   return true;
  // }
  //
  // Future<bool> sendOTP(String email) async {
  //   dynamic data = await Api().post(url: 'email/sendOtp/' + email);
  //   return true;
  // }
  //
  // Future<bool> verifyOTP(String email, String OTP) async {
  //   dynamic data = await Api().post(
  //       url: 'email/verifyEmail',
  //       body: jsonEncode({"otp": OTP, "email": email}));
  //   return true;
  // }
  //
  // Future<bool> createUser(String name, String email, String img,
  //     String password, String gender, String phoneNumber) async {
  //   String data = await Api().post(
  //       url: 'insecure/userDetails',
  //       body: jsonEncode({
  //         "username": name,
  //         "email": email,
  //         "social": false,
  //         "img": img,
  //         "password": password,
  //         "gender": gender,
  //         "phone": phoneNumber
  //       }));
  //   String token = data.substring(10, data.length - 2);
  //   const storage = FlutterSecureStorage();
  //   await storage.write(key: 'token', value: token);
  //   var value = await storage.read(key: 'token');
  //   return true;
  // }
  //
  // Future getAllFavServices() async {
  //   String token = await getToken();
  //   final response = await http.get(
  //     Uri.parse('$baseURL/getFavList'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     List<Service> services = favServiceFromJson(response.body);
  //     List<int> id = [];
  //     services.forEach((element) {
  //       id.add(element.id);
  //     });
  //     return Success(code: 200, response: id);
  //   } else {
  //     throw Exception('Failed to load services');
  //   }
  // }

  Future login(email, password) async {
    String url = '$LOGIN';
    print(email+password);
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({"email": email, "password": password})
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: jsonDecode(response.body)['token'],
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: jsonDecode(response.body)["message"]);
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }

  Future forgetPassEmailVerification(email) async {
    String url = '$FORGET_PASSWORD';
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({"email": email})
      );
      if (response.statusCode == 201) {
        return Success(
          code: 200,
          response: "",

        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }

  Future forgetPassCheckOtp(email,otp) async {
    String url = '$FORGETPASSWORD_CHECK_OTP';
    try {
      http.Response response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode({"otp": otp, "email": email})
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: "",

        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }


  Future updatePAssword(email,otp,password) async {
    String url = '$UPDATE_PASSWORD';
    try {
      http.Response response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode({"email": email,"password":password,"otp": otp})
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: jsonDecode(response.body)['token'],
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }


  Future verifyEmail(email) async {
    String url = '$VERFIY_EMAIL/$email';
    print(email);
    try {
      http.Response response = await http.get(
          Uri.parse(url),
          headers: headers,
      );
      print(response.toString());
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: "",
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }


  Future sendOtp(email) async {
    String url = '$SEND_OTP/$email';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: response.body,
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }


  Future verifyOtp(email,otp) async {
    String url = '$VERIFY_OTP';
    try {
      final http.Response response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode({"otp": otp, "email": email})
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: response.body,
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }


  Future createUser( RegisterationModel model) async {
    String url = '$CREATE_USER';
    try {
      final http.Response response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: registerationModelToJson(model)
      );
      if (response.statusCode == 200) {
        return Success(
          code: 200,
          response: jsonDecode(response.body)['token'],
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException {
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
}
