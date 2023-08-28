import 'package:flutter/material.dart';
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

  static Future getAcademyFullDetails(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.academyApiGetuserData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future getMedial(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl  + Endpoints.uploadApiGetmedia),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

   static Future paymentBookFacilitySlots(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.facilityApiPayment),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future processorder(Map data) async{
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.orderprocess),
        // headers: <String, String>{
        // 'Content-Type': 'application/json',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
   static Future responseorder(Map data) async{
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.responseorder),
        // headers: <String, String>{
        // 'Content-Type': 'application/json',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future getVenues(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.venueApiGetAllData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future getVenueDetails(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.venueApiGetsingleData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future fetchFacilitySlots(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.facilityApiGetFacilitySlots),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future bookFacilitySlots(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.facilityApiFacilityBooking),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
   static Future getExperiences(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.experiencetournamentApiGetAllData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future getExperienceDetails(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.experienceApiGetsingleitemData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

  static Future<http.Response> markUnmarkTournament(Map data) async {
    var client = http.Client();
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl  + Endpoints.likeUnlikeTournament),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    return response;
  }

  static Future<http.Response> fetchLikedTournaments(Map data) async {
    var client = http.Client();
    final response = await client.post(Uri.parse(ApiInterface.baseUrl + Endpoints.getLikedTournament), body: data);
    return response;
  }
  static Future getTournamentsDetails(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl  + Endpoints.tournamentApiGetsingleitemData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future getTournaments(Map data) async {
    var client = http.Client();
    print(data);

    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl  + Endpoints.tournamentApiGetAllData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
static Future getSearchDataByText(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.searchApiGetDatabytext),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
  static Future deleteProfile(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.DELETE_ACCOUNT),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
   static Future changepass(Map data) async {
   var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.CHANGE_PASSWORD),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }

   static Future fetchOrders(Map data) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.post(
        Uri.parse(ApiInterface.baseUrl + Endpoints.orderApigGtAllData),
        // headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: /*jsonEncode(*/data/*)*/);
    responseJson = returnResponse(response);
    return responseJson;
  }
}
