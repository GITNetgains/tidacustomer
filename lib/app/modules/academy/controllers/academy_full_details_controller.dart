import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/facility_payment_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/data/models/get_media_model.dart' as m;
import 'package:tida_customer/app/modules/academy/models/academy_full_details.dart';
import 'package:tida_customer/app/routes/app_pages.dart';

class AcademyFullDetailsController extends GetxController {
  static MethodChannel channel = MethodChannel('easebuzz');
  RxBool isLoading = false.obs;
  List<Datum?> academies = List.empty(growable: true);
  List<String> images = [];
  String? acName = "", acDescription = "", acAdd = "", accAvail = "";
  String? contactNo = "000000000";
  List<String>? amenities = List.empty(growable: true);
  List<Package?>? packages = List.empty(growable: true);
  RxString userId = "".obs;
  double? actualRating = 0.0;
  RxString userName = "".obs;
  RxString token = "".obs;
  RxString acadmeyId = "".obs;
  RxString packageId = "".obs;
  List<String> tags = [];
  String lat = "";
  String lng = "";
  RxBool isBooking = false.obs;
  String? bookingAmt = "";

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isLoading(true);
    userId.value = MySharedPref.getid().toString();
    userName.value = MySharedPref.getName().toString();
    token.value = MySharedPref.getauthtoken().toString();
    Map params = Get.parameters;
    var id = params["id"];
    acadmeyId(id.toString());
    await getAcademyDetails(id);
    isLoading(false);
    update();
  }

  Future<void> paymentFacilitySlot() async {
    var data = {
      "userid": userId.value.toString(),
      "token": token.value,
      "partner_id": academies![0]!.userId.toString(),
      "amount": bookingAmt.toString(),
      "booking_user_id": userId.value.toString(), //"1",
      "type": "2", //facilityId.toString(),
      "session_id": packageId.value, //acadmeyId, //or PackageId
      "payment_status": "2",
      "transaction_type": "1",
      "transaction_id": "",
      "transaction_ticket_id": ""
    };
    print(data);
    update();
    await ApiService.paymentBookFacilitySlots(data).then((response) async {
      FacilityPaymentResModel? res = facilityPaymentResModelFromJson(response);
      if (res.status!) {
        isBooking(false);
        update();
        var datainp = {
          "userid": userId.value.toString(),
          "token": token.value,
          "order_id": res.order_id.toString()
        };
        print("-------------------$datainp------------------------");
        try {
          ApiService.processorder(datainp).then((respons) async {
            var datinpns = {
              "easepayid": jsonDecode(respons)["data"],
              "order_id": res.order_id.toString(),
              "status": "1",
              "token": token.value,
              "userid": userId.value.toString()
            };
            String result = await easbuzzpayment(datinpns["easepayid"]);
            resonseapi(datinpns, result);
          });
        } catch (e) {
          Get.snackbar("Payment Error", "Couldnt initate Payment",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
        // Get.to(() => PaymentScreen(""));
        // await initPaymentSheet(bookingAmt.toString(), res.order_id.toString());
        isLoading(false);
        update();
      } else {
        isBooking(false);
        update();
      }
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
      isBooking(false);
      isLoading(false);
      update();
    });
  }

  Future resonseapi(Map data, String result) async {
    // print(datinpns);
    try {
      if (result == "payment_successfull") {
        await ApiService.responseorder(data).then((respons) {
          Get.snackbar("Payment Sucessful", "Slot booked successfully",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          Future.delayed(Duration(milliseconds: 10), () {
            Get.offNamedUntil(AppPages.HOME, ModalRoute.withName('/home'));
          });
        });
      } else {
        Get.snackbar("Payment Error", "Couldn't Process Payment",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Payment Error", result,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<String> easbuzzpayment(accesskey) async {
    String access_key = accesskey;
    String pay_mode = "production";
    Object parameters = {"access_key": access_key, "pay_mode": pay_mode};
    final Map response =
        await channel.invokeMethod("payWithEasebuzz", parameters);
    String result = response['result'];
    return result;
  }

  Future<void> getAcademyDetails(id) async {
    var data = {
      "userid": userId.value.toString(),
      "token": token.value,
      "id": id.toString()
    };
    print(data);
    await ApiService.getAcademyFullDetails(data).then((response) async {
      AcademyFullDetailResponse? res =
          academyFullDetailResponseFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");
        academies.addAll(res.data!);
        if (academies.isNotEmpty) {
          acName = academies[0]!.name!;
          acDescription = academies[0]!.description!;
          acAdd = academies[0]!.venueDetails?.first?.address!;
          accAvail = academies[0]!.sessionTimings!;
          contactNo = academies[0]!.contactNo;
          if (academies[0]!.amenitiesDetails != null &&
              academies[0]!.amenitiesDetails!.isNotEmpty) {
            for (var i = 0; i < academies[0]!.amenitiesDetails!.length; i++) {
              amenities!
                  .add(academies[0]!.amenitiesDetails![i]!.name!.toString());
            }
          }

          if (academies[0]!.packages!.isNotEmpty) {
            packages!.addAll(academies[0]!.packages!);
          }
          if (academies[0]!.latitude!.isNotEmpty) {
            lat = academies[0]!.latitude;
          }
          if (academies[0]!.longitude!.isNotEmpty) {
            lng = academies[0]!.longitude;
          }

          if (academies[0]!.rating!.isNotEmpty) {
            String? rate =
                academies.first!.rating!.first.rating.toString().trim();
            if (rate.isNotEmpty) {
              dynamic rating = double.parse(rate);
              actualRating = rating;
            }
          }

          await getVenueImgs(
              academies[0]!.venueId.toString(), academies[0]!.logo ?? "");
        }

        debugPrint(" academies ${academies.length},  ");
        update();
      } else {
        debugPrint("IN hEEre3");
        Get.snackbar("Error", "${res.message}");
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

  Future<void> getVenueImgs(id, String coverImageUrl) async {
    var data = {
      "userid": userId.value.toString(),
      "token": token.value,
      "post_id": id.toString(),
      "post_type": "venue"
    };

    await ApiService.getMedial(data).then((response) {
      m.MediaResponseModel? res = m.mediaResponseModelFromJson(response);
      if (res.status!) {
        images.clear();
        for (var i = 0; i < res.data!.length; i++) {
          images.add(res.data![i].image!);
        }
      } else {
        //Get.snackbar("Error", "${res.message}");
      }

      if (images.isEmpty && coverImageUrl.isNotEmpty) {
        images.add(coverImageUrl);
      }
      update();
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
    });
  }
}
