import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/experience/models/experience_list_reponse.dart';
import 'package:tida_customer/utils/common_utils.dart';

class ExperienceListController extends GetxController {
  String? userId, userName, token;
  List<Datum?>? experiences = List.empty(growable: true);
  bool? isLoading = true;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId =  MySharedPref.getid();
    userName =  MySharedPref.getName();
    token =  MySharedPref.getauthtoken();

    await getExperiences();
    isLoading = false;
    update();
  }

  Future<void> getExperiences() async {
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
    debugPrint("e data $data");
    await ApiService.getExperiences(data).then((response) {
      ExperienceDetails? res = experienceDetailsFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");

        experiences!.addAll(res.data!);

        debugPrint(" experience ${experiences!.length},  ");
        update();
      } else {
        debugPrint("IN hEEre3");
       // Get.snackbar("Error", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
    });
  }
}
