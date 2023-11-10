import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tida_customer/app/data/remote/api_interface.dart';
import 'package:tida_customer/app/data/remote/endpoints.dart';

class ApiService {
  static dynamic returnResponse(http.Response response) {
    try {
      dynamic responseJson = /*jsonDecode(*/ response.body /*)*/;
      debugPrint("RESPONSE $responseJson");
      return responseJson;
    } catch (e) {
      return {};
    }
  }

  static Future login(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.customerlogin),
          // headers: <String, String>{
          // 'Content-Type': 'application/json',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future register(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.customerregister),
          // headers: <String, String>{
          // 'Content-Type': 'application/json',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future logout(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response =
          await client.post(Uri.parse(ApiInterface.baseUrl + Endpoints.logout),
              // headers: <String, String>{
              // 'Content-Type': 'application/json',
              // },
              body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future forgotPass(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.forgotpassword),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getSearchNearByLoc(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.searchApiGetDatanearbyloc),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getSportsData(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.sportApiGetAllData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getSearchBySport(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.searchApiGetDatabysport),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/ data /*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future getAcademies(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.academyApiGetAllData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future sendBookingNotification(int partnerId, int orderId) async {
    late String fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    } catch (e) {
      // Get.snackbar("Error",
      //     "An error has occured",
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //     snackPosition: SnackPosition.BOTTOM);
      print(e);
    }

    try {
      var client = http.Client();
      dynamic responseJson;
      Map body = {
        "userid": partnerId.toString(),
        "fcmToken": fcmToken,
        "order_id": orderId
      };
      print(body);
      final response = await client.post(
        Uri.parse(ApiInterface.notificationServiceUrl +
            Endpoints.sendBookingNotification),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      // print("++++++++++++++++++++++++++++++++++++++++++++++");
      print(e);
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getAcademyFullDetails(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.academyApiGetuserData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getMedial(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.uploadApiGetmedia),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future paymentBookFacilitySlots(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.facilityApiPayment),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future processorder(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.orderprocess),
          // headers: <String, String>{
          // 'Content-Type': 'application/json',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future responseorder(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.responseorder),
          // headers: <String, String>{
          // 'Content-Type': 'application/json',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getVenues(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.venueApiGetAllData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getVenueDetails(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.venueApiGetsingleData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future fetchFacilitySlots(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(
              ApiInterface.baseUrl + Endpoints.facilityApiGetFacilitySlots),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future bookFacilitySlots(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(
              ApiInterface.baseUrl + Endpoints.facilityApiFacilityBooking),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getExperiences(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl +
              Endpoints.experiencetournamentApiGetAllData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getExperienceDetails(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(
              ApiInterface.baseUrl + Endpoints.experienceApiGetsingleitemData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future markUnmarkTournament(Map data) async {
    try {
      var client = http.Client();
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.likeUnlikeTournament),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      return response;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future fetchLikedTournaments(Map data) async {
    try {
      var client = http.Client();
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.getLikedTournament),
          body: data);
      return response;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getTournamentsDetails(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(
              ApiInterface.baseUrl + Endpoints.tournamentApiGetsingleitemData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getTournaments(Map data) async {
    try {
      var client = http.Client();
      print(data);

      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.tournamentApiGetAllData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getSearchDataByText(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.searchApiGetDatabytext),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future deleteProfile(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.DELETE_ACCOUNT),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future changepass(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.CHANGE_PASSWORD),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future fetchOrders(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.orderApigGtAllData),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future getCMS(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.cmsApiGetAllData),
          body: /*jsonEncode(*/ data /*)*/);
      //responseJson = returnResponse(response);
      return response;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static Future saveRating(Map data) async {
    try {
      var client = http.Client();
      dynamic responseJson;
      final response = await client.post(
          Uri.parse(ApiInterface.baseUrl + Endpoints.SAVE_RATING),
          // headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // },
          body: /*jsonEncode(*/ data /*)*/);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
