import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/facility_payment_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/Booking/model/AllOrdersResponse.dart';
import 'package:tida_customer/app/modules/Home/models/logout_model.dart';
import 'package:tida_customer/app/modules/facility/models/facility_booking_model.dart'
    as book;
import 'package:tida_customer/app/routes/app_pages.dart';

class BookingController extends GetxController {
  static MethodChannel channel = MethodChannel('easebuzz');
  String? userId, userName, token;
  RxBool loading = false.obs;
  RxList<Data> orderList = <Data>[].obs;
  RxInt index = (-1).obs;
  RxDouble rating = 3.0.obs;
  TextEditingController reviewController = TextEditingController();
  bool isLoading = false;
  bool isBooking = false;
  String? slotId = "";
  RxString selectedBookingId = "".obs;

  @override
  Future<void> onInit() async {
    await init();
    if (selectedBookingId.value != "") {
      for (int i = 0; i < orderList.length; i++) {
        if (orderList[i].id == selectedBookingId.value) {
          index(i);
        }
      }
    }
    update();
    super.onInit();
  }

  Future<void> init() async {
    loading(true);
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();
    await fetchOrders();
    loading(false);
    update();
  }

  Future<void> fetchOrders() async {
    loading(true);
    orderList.clear();
    var data = {"userid": userId.toString(), "token": token};
    AllOrdersResponse? response =
        allOrdersResponseFromJson(await ApiService.fetchOrders(data));
    if (response != null) {
      if (response.data != null) {
        orderList.assignAll(response.data!);
        orderList = orderList.reversed.toList().obs;
      }
    }
    loading(false);
  }

  Data getSelectedOrder() {
    return orderList[index.value];
  }

  Future<void> saveRating() async {
    loading(true);
    update();
    var data = {
      "userid": userId.toString(), //"3",
      "token": token,
      "status": "1",
      "post_id": _getPostId(getSelectedOrder().type.toString()),
      "review": reviewController.text.trim(),
      "post_type": _getOrderType(getSelectedOrder().type.toString()),
      "rating": rating.toString()
    };
    print(data);
    await ApiService.saveRating(data).then((response) async {
      LogoutResponseModel? res = logoutResponseModelFromJson(response);
      debugPrint("IN hEEre1");
      if (res.status!) {
        debugPrint("IN hEEre");
        loading(false);
        update();
        reviewController.clear();
        //  MySharedPref.clearSession();
        Get.back();
      } else {
        debugPrint("IN hEEre3");
        Get.snackbar("Error", "${res.message}");
        loading(false);
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
      loading(false);
    });
  }

  Future<void> bookFacilitySlot(
      startTime, endTime, facilityId, slotdate, partnerid, amt) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "booking_user_id": userId.toString(),
      "facility_id": facilityId,
      "date": slotdate,
      "start_time": startTime,
      "end_time": endTime
    };
    debugPrint("v1 data $data");
    await ApiService.bookFacilitySlots(data).then((response) {
      book.SlotBookingResponseModel? res =
          book.slotBookingResponseModelFromJson(response);
      if (res.status!) {
        slotId = res.data!.isNotEmpty ? res.data![0].id.toString() : null;
        paymentFacilitySlot(partnerid, amt, slotId.toString());
        update();
      } else {
        isBooking = false;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
      isBooking = false;
      isLoading = false;
      update();
    });
  }

  Future<void> exppaymentSlot(partnerid, amt, expid) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "partner_id": partnerid,
      "amount": amt.toString(),
      "booking_user_id": userId.toString(),
      "type": "4", //facilityId.toString(),
      "experience_id": expid,
      "payment_status": "2",
      "transaction_type": "1",
      "transaction_id": "",
      "transaction_ticket_id": ""
    };
    debugPrint("v1 data 2 $data");

    await ApiService.paymentBookFacilitySlots(data).then((response) async {
      FacilityPaymentResModel? res = facilityPaymentResModelFromJson(response);
      if (res.status!) {
        isBooking = false;
        update();
        var datainp = {
          "userid": userId.toString(),
          "token": token,
          "order_id": res.order_id.toString()
        };
        try {
          ApiService.processorder(datainp).then((respons) async {
            var datinpns = {
              "easepayid": jsonDecode(respons)["data"],
              "order_id": res.order_id.toString(),
              "status": "1",
              "token": token,
              "userid": userId.toString()
            };
            String result = await easbuzzpayment(datinpns["easepayid"]);
            resonseapi(datinpns, result, partnerid, res.order_id ?? 0);
          });
        } catch (e) {
          Get.snackbar("Payment Error", "Couldnt initate Payment",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
        // Get.to(() => PaymentScreen(""));
        // await initPaymentSheet(bookingAmt.toString(), res.order_id.toString());
        isLoading = false;
        update();
      } else {
        isBooking = false;
        update();
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
      isBooking = false;
      isLoading = false;
      update();
    });
  }

  Future<void> academyexppayment(partnerid, bookingAmt, packageId) async {
    print("$partnerid,$bookingAmt,$packageId");
    var data = {
      "userid": userId.toString(),
      "token": token,
      "partner_id": partnerid,
      "amount": bookingAmt.toString(),
      "booking_user_id": userId.toString(), //"1",
      "type": "2", //facilityId.toString(),
      "session_id": packageId, //acadmeyId, //or PackageId
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
        isBooking = false;
        update();
        var datainp = {
          "userid": userId.toString(),
          "token": token,
          "order_id": res.order_id.toString()
        };
        print("-------------------$datainp------------------------");
        try {
          ApiService.processorder(datainp).then((respons) async {
            var datinpns = {
              "easepayid": jsonDecode(respons)["data"],
              "order_id": res.order_id.toString(),
              "status": "1",
              "token": token,
              "userid": userId.toString()
            };
            String result = await easbuzzpayment(datinpns["easepayid"]);
            resonseapi(datinpns, result, partnerid, res.order_id ?? 0);
          });
        } catch (e) {
          Get.snackbar("Payment Error", "Couldnt initate Payment",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
        // Get.to(() => PaymentScreen(""));
        // await initPaymentSheet(bookingAmt.toString(), res.order_id.toString());
        isLoading = false;
        update();
      } else {
        isBooking = false;
        update();
      }
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
      isBooking = false;
      isLoading = false;
      update();
    });
  }

  Future<void> paymentFacilitySlot(
      String partner_id, String amt, String slotId) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "partner_id": partner_id,
      "amount": amt.toString(),
      "booking_user_id": userId.toString(),
      "type": "1", //facilityId.toString(),
      "facility_booking_id": slotId,
      "payment_status": "2",
      "transaction_type": "1",
      "transaction_id": "",
      "transaction_ticket_id": ""
    };
    update();
    print(data);
    await ApiService.paymentBookFacilitySlots(data).then((response) async {
      FacilityPaymentResModel? res = facilityPaymentResModelFromJson(response);
      if (res.status!) {
        isBooking = false;
        update();
        var datainp = {
          "userid": userId.toString(),
          "token": token,
          "order_id": res.order_id.toString()
        };
        try {
          ApiService.processorder(datainp).then((respons) async {
            var datinpns = {
              "easepayid": jsonDecode(respons)["data"],
              "order_id": res.order_id.toString(),
              "status": "1",
              "token": token,
              "userid": userId.toString()
            };
            // String result = await easbuzzpayment(datinpns["easepayid"]);
            // print(result);
            resonseapi(
                datinpns, "payment_successfull", partner_id, res.order_id ?? 0);
          });
        } catch (e) {
          Get.snackbar("Payment Error", "Couldnt initate Payment",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
        isLoading = false;
      } else {
        debugPrint("IN hEEre3");
      }
      isBooking = false;
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
      isBooking = false;
      isLoading = false;
      update();
    });
  }

  Future<String> easbuzzpayment(accesskey) async {
    String access_key = accesskey;
    String pay_mode = "production";
    Object parameters = {"access_key": access_key, "pay_mode": pay_mode};
    final Map response =
        await channel.invokeMethod("payWithEasebuzz", parameters);
    String result = response['result'];
    // print(response);
    return result;
  }

  Future resonseapi(
      Map data, String result, String partnerId, int orderId) async {
    // print(datinpns);
    try {
      if (result == "payment_successfull") {
        try {
          ApiService.sendBookingNotification(int.parse(partnerId), orderId);
        } catch (e) {
          print(e);
        }
        await ApiService.responseorder(data).then((respons) {
          Get.snackbar("Sucessful", "Slot booked successfully",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          Future.delayed(Duration(milliseconds: 10), () {
            // Get.toNamed(AppPages.LOGIN);
            Get.toNamed(AppPages.ORDERS);
          });
        });
      } else {
        Get.snackbar("Payment Error", "Couldnt Process Payment",
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

  _getOrderType(String type) {
//type: 1-venue/facility,2-academy/session,3-tournament,4-experience
    switch (type) {
      case "1":
        return "venue";

      case "2":
        return "academy";
      case "3":
        return "tournament";
      case "4":
        return "experience";

      default:
        return "N/A";
    }
  }

  _getPostId(String type) {
//type: 1-venue/facility,2-academy/session,3-tournament,4-experience
    switch (type) {
      case "1":
        return getSelectedOrder().facility?.venueId.toString();

      case "2":
        return getSelectedOrder().packages?.academy;
      case "3":
        return getSelectedOrder().tournament?.academyId;
      case "4":
        return getSelectedOrder().experience?.venueId.toString();

      default:
        return "N/A";
    }
  }
}
