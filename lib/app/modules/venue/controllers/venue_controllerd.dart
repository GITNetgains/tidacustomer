import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/venue/models/venue_details_model.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueController extends GetxController
{
  String? userId, userName, token;
  List<Datum?> venues = List.empty(growable: true);
  RxBool isLoading = true.obs, hasCallSupport = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }
  Future<void> init() async {
    userId =  MySharedPref.getid();
    userName = MySharedPref.getName();
    token =  MySharedPref.getauthtoken();

    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
        hasCallSupport(result);
    });

    await getVenues();
    
    isLoading(false);
    update();
  }
  Future<void> getVenues() async {
    var lati = MySharedPref.getlati();
    var lngi = MySharedPref.getlongi();
    String lat = "";
    String lng = "";
    if (isProperString(lati)! && isProperString(lngi)!) {
      lat = lati.toString();
      lng = lngi.toString();
    }
    var data = {
      "userid": userId.toString(),
      "token": token,
      "latitude": lat.toString(), // "30.7165768",
      "longitude": lng.toString(), //"76.7440272",
    };
    debugPrint("v data $data");
    venues.clear();
    await ApiService.getVenues(data).then((response) {
      VenueDetails? res = venueDetailsFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");

        venues.addAll(res.data!);

        debugPrint(" venues ${venues!.length},  ");
        update();
      } else {
        debugPrint("IN hEEre3");
        //Get.snackbar("Error", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
    });
  }
}