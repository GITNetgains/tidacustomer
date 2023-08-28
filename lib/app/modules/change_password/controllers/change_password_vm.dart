import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/change_password/models/change_password_model.dart';

class ChangePasswordController extends GetxController {
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  void showSnackbar(msg) {
    Get.snackbar("Please provide $msg", "$msg is required.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> changepass() async {
    if (newpassword.text.trim().isEmpty) {
      showSnackbar("New Password");
      return;
    } else if (confirmpassword.text.trim().isEmpty) {
      showSnackbar("Confirm Password");
      return;
    } else {
      if (confirmpassword.text.trim() != newpassword.text.trim()) {
        Get.snackbar("Not Matching","Confirm Password not matching newpassword",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        return;
      } else {
        print(MySharedPref.getid());
        Map<String,String> data = {
          "token": MySharedPref.getauthtoken() ?? "",
          "userid":MySharedPref.getid() ?? "",
          "new_password": newpassword.text.trim()
        };
        print(data);
        await ApiService.changepass(data).then((res) async {
        ChangePasswordModel? resp = ChangePasswordModelFromJson(res);print("-------------");
          if (resp!.status == false) {
            Get.snackbar("Server Response", "${resp.message}",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
          } else {
            Get.snackbar("Server Response", "${resp.message}",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
          }
        }).onError((error, stackTrace) {
          Get.snackbar("Server Response", error.toString(),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        });
      }
    }
  }
}
