import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/login/models/Login_model.dart';
import 'package:tida_customer/app/modules/sports/models/sports_data_response.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/common_utils.dart';

class LoginController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailFPCtrl = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    isLoading(true);
    var token = await MySharedPref.getauthtoken();
    print(token);
    if (token != null &&
        token.toString().trim().isNotEmpty &&
        token.toString().trim() != "null") {
      isLoading(false);
      update();
    // getCMSData();
      getSportsData();
      Get.offAllNamed(AppPages.HOME);
    } else {
      print("--------------");
      isLoading(false);
      update();
    }
    isLoading(false);
  }


 Future<void> getCMSData() async {
    // var data = {
    //   "userid": userId.toString(), //"3",
    //   "token": token //"dfdd92bea16946f54b1cfe794dca3db9",
    // };

    // await ApiService.getCMS(data).then((response) async {
    //   print(jsonEncode(response.body));
    //   PagesResponse r = PagesResponse.fromJson(jsonDecode(response.body));
    //   if (r.status == true) {
    //     if (r.data != null) {
    //       r.data?.forEach((element) {
    //         if (element.title.toString().toLowerCase().contains("about")) {
    //           aboutUsPageText = element.description;
    //         }
    //         if (element.title.toString().toLowerCase().contains("terms")) {
    //           tncPageText = element.description;
    //         }
    //         if (element.title.toString().toLowerCase().contains("privacy")) {
    //           ppPageText = element.description;
    //         }
    //         if (element.title.toString().toLowerCase().contains("faq")) {
    //           faq = element.description;
    //         }
    //       });
    //     }
    //   }
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
    // });
  }


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

  Future<void> login() async {
    if (emailcontroller.text.trim().isEmpty) {
      showSnackbar("email");
      return;
    } else if (passwordcontroller.text.trim().isEmpty) {
      showSnackbar("Password");
      return;
    } else {
      var data = {
        "email": emailcontroller.text.trim(),
        "password": passwordcontroller.text.trim(),
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_token": "12345"
      };
      isLoading(true);
      update();
      ApiService.login(data).then((res) async {
        LoginResponseModel? resp = loginResponseModelFromJson(res);
        if (resp!.status == true) {
          if (resp.data?.status.toString() == "2" ||
              resp.data?.status.toString() == "2") {
            Get.snackbar("Account Deletion",
                "Your account is set for deletion, Please contact support for further communication.",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
            return;
          }
          if (resp.data?.type.toString() == "2") {
            Get.snackbar("Account",
                "Your account is associated with Tida Sports as a partner, Please use different login details to login as a customer.",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
            return;
          }
          print(resp.data!.id);
          MySharedPref.setid(resp.data!.id.toString());
          print(MySharedPref.getid());
          MySharedPref.setName(resp.data!.name.toString());
          print(MySharedPref.getid());
          MySharedPref.setauthtoken(resp.data!.token.toString());
          MySharedPref.setemail(resp.data!.email.toString());
          MySharedPref.setphone(resp.data!.phone.toString());
          MySharedPref.setavatar(resp.data!.image.toString());
          Get.snackbar("Server Response", "${resp.message}",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          isLoading(false);
          update();
    getCMSData();
          getSportsData();
          Get.offAllNamed(AppPages.HOME);
        } else {
          isLoading(false);
          update();
          Get.snackbar("Invalid Crediantials", resp.message.toString(),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
      });
    }
  }

  void showSnackbar(msg) {
    Get.snackbar("Please provide $msg", "$msg is required.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void forgotpassworddialog() {
    Get.dialog(Center(
      child: Wrap(
        children: [
          Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Forgot password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.2)),
                    child: TextField(
                      controller: emailFPCtrl,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                          hintText: "johndoe@hotmail.com",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  getVerticalSpace(),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red)),
                      onPressed: () async {
                        Get.back();
                        await forgotpassword();
                        // Get.back();
                        // Get.back();
                      },
                      child: const Text("Send me password"))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> forgotpassword() async {
    if (emailFPCtrl.text.trim().isEmpty) {
      showSnackbar("email");
      return;
    } else if (emailFPCtrl.text.trim().isNotEmpty &&
        !validateEmail(emailFPCtrl.text.trim())) {
      showSnackbar("valid email");
      return;
    } else {
      var data = {"email": emailFPCtrl.text.trim()};
      debugPrint("fp data $data");
      await ApiService.forgotPass(data).then((res) async {
        LoginResponseModel? resp = loginResponseModelFromJson(res);
        if (resp!.status!) {
          Get.snackbar("Server Response", "${resp.message}",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Server Response", "${resp.message}",
              backgroundColor: Colors.red,
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
