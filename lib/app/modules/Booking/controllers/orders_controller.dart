import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/Booking/model/AllOrdersResponse.dart';

class BookingController extends GetxController
{
    String? userId, userName, token;
  RxBool loading = false.obs;
  RxList<Data> orderList = <Data>[].obs;
  RxInt index = (-1).obs;
  RxDouble rating = 3.0.obs;
  TextEditingController reviewController = TextEditingController();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();
    fetchOrders();
  }

  void fetchOrders() async {
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

  // Future<void> saveRating() async {
  //   loading(true);
  //   update();
  //   var data = {
  //     "userid": userId.toString(), //"3",
  //     "token": token,
  //     "status": "1",
  //     "post_id": _getPostId(getSelectedOrder().type.toString()),
  //     "review": "",
  //     "post_type": _getOrderType(getSelectedOrder().type.toString()),
  //     "rating": rating.toString()
  //   };
  //   await ApiService.saveRating(data).then((response) async {
  //     LogoutResponseModel? res = logoutResponseModelFromJson(response);
  //     debugPrint("IN hEEre1");
  //     if (res.status!) {
  //       debugPrint("IN hEEre");
  //       loading(false);
  //       update();
  //        MySharedPref.clearSession();
  //       Get.back();
  //     } else {
  //       debugPrint("IN hEEre3");
  //       Get.snackbar("Error", "${res.message}");
  //       loading(false);
  //     }
  //   }).onError((error, stackTrace) {
  //     debugPrint("IN hEEr4 ${error.toString()}");
  //     Get.snackbar("Error", error.toString());
  //     loading(false);
  //   });
  // }

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