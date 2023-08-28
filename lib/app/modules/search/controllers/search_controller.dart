import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/nearby_search_response.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';

class SearchScreenController extends GetxController
{
   @override
  void onInit() {
    super.onInit();
    init();
  }

  String? userId, userName, token, lat = "0.0", lng = "0.0";

  List<Venue?>? venues = List.empty(growable: true);
  List<Academy?>? academies = List.empty(growable: true);
  List<Tournament?>? tournaments = List.empty(growable: true);
  List<Experience?>? experiences = List.empty(growable: true);

  TextEditingController searchCtr = TextEditingController();

  String? tags = "";
  String? radius = "10";

  bool? isLoading = false;
  bool? showNoData = true;
  bool? isSearchEmpty = false;

  void init() async {
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();
    var lati = MySharedPref.getlati();
    var lngi = MySharedPref.getlongi();
    if (isProperString(lati)!) {
      lat = lati.toString();
    }
    if (isProperString(lngi)!) {
      lng = lngi.toString();
    }
    update();
  }

  bool? isProperString(String? s) {
    if (s != null &&
        s.toString().trim().isNotEmpty &&
        s.toString().trim() != "null") {
      return true;
    }
    return false;
  }

  Future<void> getData(String query) async {
    var lati = MySharedPref.getlati();
    var lngi = MySharedPref.getlongi();
    if (isProperString(lati)!) {
      lat = lati.toString();
    }
    if (isProperString(lngi)!) {
      lng = lngi.toString();
    }
    var data = {
      "userid": userId.toString(),
      "token": token,
      "latitude": lat,
      "longitude": lng,
      "distance_km": radius!.trim().isNotEmpty ? radius! : "10",
      "search": query.toString(),
    };
    if (tags!.trim().isNotEmpty) {
      data["type"] = tags!.toLowerCase();
    }

    debugPrint("Search Req json $data");

    await ApiService.getSearchDataByText(data).then((response) {
      debugPrint("search res $response");
      NearbyDataResponse? res = nearbyDataResponseFromJson(response);
      debugPrint("IN hEEre1");
      if (isSearchEmpty!) {
        clearLists();
        isLoading = false;
      } else {
        if (res!.status!) {
          debugPrint("IN hEEre");
          clearLists();
          venues!.addAll(res.data!.venue!);
          academies!.addAll(res.data!.academy!);
          tournaments!.addAll(res.data!.tournament!);
          experiences!.addAll(res.data!.experience!);
          debugPrint(
              "Venues ${venues!.length}, academies ${academies!.length}, tournaments ${tournaments!.length}, experience ${experiences!.length} ");
          update();
        } else {
          clearLists();
          showNoData = true;
          isLoading = false;
          debugPrint("IN hEEre3");
          debugPrint(
              "Venues ${venues!.length}, academies ${academies!.length}, tournaments ${tournaments!.length}, experience ${experiences!.length} ");
          //Get.snackbar("Error", "${res.message}");
        }
      }
      update();
    }).onError((error, stackTrace) {
      clearLists();
      showNoData = true;
      isLoading = false;
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
      debugPrint(
          "Venues ${venues!.length}, academies ${academies!.length}, tournaments ${tournaments!.length}, experience ${experiences!.length} ");
      update();
    });
  }

  void clearLists() {
    venues!.clear();
    academies!.clear();
    tournaments!.clear();
    experiences!.clear();
  }
}