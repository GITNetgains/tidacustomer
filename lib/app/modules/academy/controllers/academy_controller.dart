import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/academy/models/academy_full_details.dart';
import 'package:tida_customer/utils/common_utils.dart';

class AcademyController extends GetxController {
  List<Datum?>? academies = List.empty(growable: true);
  RxString userId = "".obs;
  RxString token = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    isLoading(true);
    userId(MySharedPref.getid());
    token(MySharedPref.getauthtoken());
    getAcademies();
    isLoading(false);
    super.onInit();
  }

  Future<void> getAcademies() async {
    academies!.clear();
    var lati = await MySharedPref.getlati();
    var lngi = await MySharedPref.getlongi();
    String lat = "";
    String lng = "";
    if (isProperString(lati)! && isProperString(lngi)!) {
      lat = lati.toString();
      lng = lngi.toString();
    }
    academies?.clear();
    var data = {
      "userid": userId.value.toString(),
      "token": token.value,
      "latitude": lat.toString(), // "30.7165768",
      "longitude": lng.toString(), //"76.7440272",
    };
    await ApiService.getAcademies(data).then((response) {
      AcademyFullDetailResponse? res =
          academyFullDetailResponseFromJson(response);
      if (res!.status!) {
        academies!.addAll(res.data!);
        academies!.sort((a, b) {
          double distanceA = double.tryParse(a!.distance ?? '') ?? 0.0;
          double distanceB = double.tryParse(b!.distance ?? '') ?? 0.0;
          return distanceA.compareTo(distanceB);
        });
        update();
      } else {
        //Get.snackbar("Error", "${res.message}");
      }
      isLoading(false);
      update();
    }).onError((error, stackTrace) {
      isLoading(false);
      update();
      Get.snackbar("Error", error.toString());
    });
  }
}
