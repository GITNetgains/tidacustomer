import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/pages_response_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController
{
  String? aboutUsPageText = "";
  String? tncPageText = "";
  String? ppPageText = "";
  String? faq = "";

@override
  void onInit() async{
    await getCMSData();
    super.onInit();
  }

  Future launchurl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  Future<void> getCMSData() async {
    var data = {
      "userid": MySharedPref.getid(), //"3",
      "token": MySharedPref.getauthtoken() //"dfdd92bea16946f54b1cfe794dca3db9",
    };

    await ApiService.getCMS(data).then((response) async {
      print(jsonEncode(response.body));
      PagesResponse r = PagesResponse.fromJson(jsonDecode(response.body));
      if (r.status == true) {
        if (r.data != null) {
          r.data?.forEach((element) {
            if (element.title.toString().toLowerCase().contains("about")) {
              aboutUsPageText = element.description;
            }
            if (element.title.toString().toLowerCase().contains("terms")) {
              tncPageText = element.description;
            }
            if (element.title.toString().toLowerCase().contains("privacy")) {
              ppPageText = element.description;
            }
            if (element.title.toString().toLowerCase().contains("faq")) {
              faq = element.description;
            }
          });
        }
      }
      // cms.CmsResModel? res = cms.cmsResModelFromJson(response);
      /* debugPrint("IN hEEre1");
      if (res.status!) {

      } else {
        debugPrint("IN hEEre3");
       // Get.snackbar("Error", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
     // Get.snackbar("Error", error.toString());
    });*/
    });
  }
}