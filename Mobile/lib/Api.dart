import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  String base="http://localhost:8080/";
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};

    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    http.Response response = await http.get(Uri.parse(base+url), headers: headers);

    if (response.statusCode == 200) {
      
      return (response.body.toString().length>0?jsonDecode(response.body):null);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String url,
      dynamic body,
      String? token}) async {
    Map<String, String> headers = {
      
    };
    headers.addAll({
      'Access-Control-Allow-Headers':"DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Authorization",
      'Access-Control-Allow-Origin':"*",
      'Access-Control-Allow-Credentials':"true",
      'content-Type':'application/json',
      'Accept': "application/json"
    });
    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    http.Response response =
        await http.post(Uri.parse(base+url), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if(!response.body.isEmpty){
              var data = jsonDecode(jsonEncode(response.body));
                    return data;
      }
      else{
        return null;
      }

    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
       String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }

    print('url = $url body = $body token = $token ');
    http.Response response =
        await http.put(Uri.parse(base+url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}