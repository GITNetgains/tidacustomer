import 'dart:convert';

import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/pages_response_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';

class TNCController extends GetxController
{
  RxString tncPageText = "".obs;

  @override
  void onInit() async
  {
   await getCMSData();
    super.onInit();
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
            
            if (element.title.toString().toLowerCase().contains("terms")) {
              tncPageText.value = element.description ?? "";
              update();
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