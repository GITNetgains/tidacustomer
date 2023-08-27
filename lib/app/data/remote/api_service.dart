import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tida_customer/app/data/remote/api_interface.dart';
import 'package:tida_customer/app/data/remote/endpoints.dart';

class ApiService {
  static  dynamic returnResponse(http.Response response) {
    try {
      dynamic responseJson = /*jsonDecode(*/ response.body /*)*/;
      debugPrint("RESPONSE $responseJson");
      return responseJson;
    } catch (e) {
      return {};
    }
  }
static Future login(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.customerlogin),
        // headers: <String, String>{
        // 'Content-Type': 'application/json',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

static Future register(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.customerregister),
        // headers: <String, String>{
        // 'Content-Type': 'application/json',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

static Future logout(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.logout),
        // headers: <String, String>{
        // 'Content-Type': 'application/json',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

 static Future forgotPass(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.forgotpassword),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future getSearchNearByLoc(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.searchApiGetDatanearbyloc),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future getSportsData(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.sportApiGetAllData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future getSearchBySport(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.searchApiGetDatabysport),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future getAcademies(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.academyApiGetAllData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
}
