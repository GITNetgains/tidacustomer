import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/login/models/Login_model.dart';
import 'package:tida_customer/app/modules/sports/models/sports_data_response.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/utils/common_utils.dart';

class RegisterController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  RxBool isLoading = false.obs;

   Future<void> getSportsData() async {
    var data = {
      "userid": MySharedPref.getid(), //"3",
      "token": MySharedPref.getauthtoken() //"dfdd92bea16946f54b1cfe794dca3db9",
    };

    await ApiService.getSportsData(data).then((response) {
      SportsDataResponse? res = sportsDataResponseFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");
        MySharedPref.setsportsdata(response);
        update();
      } else {
        debugPrint("IN hEEre3");
        if (res.message == "Session Expired. Please Login Again.") {
          MySharedPref.clearSession();
          Get.offAllNamed(AppPages.LOGIN);
        }
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
    });
  }

  Future<void> signup() async {
    if (namecontroller.text.trim().isEmpty) {
      showSnackbar("name");
      return;
    } else if (emailcontroller.text.trim().isEmpty) {
      showSnackbar("email");
      return;
    } 
    else if (phonecontroller.text.trim().isEmpty) {
      showSnackbar("phone number");
      return;
    } 
    else if (emailcontroller.text.trim().isNotEmpty &&
        !validateEmail(emailcontroller.text.trim())) {
      showSnackbar("valid email");
      return;
    } else if (passwordcontroller.text.trim().isEmpty) {
      showSnackbar("password");
      return;
    } else if (confirmpasswordcontroller.text.trim().isEmpty) {
      showSnackbar("confirm password");
      return;
    } else if (confirmpasswordcontroller.text.trim().isNotEmpty &&
        confirmpasswordcontroller.text.trim() !=
            passwordcontroller.text.trim()) {
      showSnackbar("matching password");
      return;
    } 
    else if( isPasswordCompliant( passwordcontroller.text.trim().toString()) == false)
    {
      Get.snackbar("Please provide valid Password", "Password should have minimum of 1 special Character, 1 Uppercase letter, 1 lowercase letter, 1 digit and minimum length of 8 characters.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
      return;
    }
    else {
       isLoading(true);
    update();
      var data = {
        "name": namecontroller.text.trim().toString(),
        "email": emailcontroller.text.trim().toString(),
        "password": passwordcontroller.text.trim().toString(),
        "phone": phonecontroller.text.trim().toString(),
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_token": "12345"
      };
      ApiService.register(data).then((res) async{
        LoginResponseModel? resp = loginResponseModelFromJson(res);
        if (resp!.status!) {
          MySharedPref.clearSession();
          MySharedPref.setid(resp.data!.id.toString());
          MySharedPref.setName(resp.data!.name.toString());
          MySharedPref.setemail(resp.data!.email.toString());
          MySharedPref.setphone(resp.data!.phone.toString());
          MySharedPref.setauthtoken(resp.data!.token.toString());
          MySharedPref.setavatar(resp.data!.image.toString());

          Get.snackbar("Server Response", "${resp.message}",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          isLoading(false);
          update();
          await getSportsData();
          Get.offAllNamed(AppPages.HOME);
        } else {
          Get.snackbar("Server Response", "${resp.message}",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          isLoading(false);
          update();
        }
      }).onError((error, stackTrace) {
        Get.snackbar("Server Response", error.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      });
      isLoading(false);
      update();
    }
  }

  void showSnackbar(msg) {
    Get.snackbar("Please provide $msg", "$msg is required.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
