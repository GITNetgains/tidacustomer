import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/facility_payment_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/experience/models/experience_list_reponse.dart';
import 'package:tida_customer/app/routes/app_pages.dart';

class ExperienceDetailsController extends GetxController
{
  String? userId, userName, token;
  static MethodChannel channel = MethodChannel('easebuzz');
  List<Datum?>? experiences = List.empty(growable: true);
  String? tName = "", tDescription = "", tAdd = "", tAvail = "";
  List<String>? amenities = List.empty(growable: true);
  String? expId = "";

  String? tDateTime = "", tBookingAmt = "", image = "";

  bool? isLoading = true;
  bool? isBooking = false;

  @override
  void onInit() {
    super.onInit();
    /* razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);*/
    init();
  }

  //final razorpay = Razorpay();

  /*void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint("payment S ${response.orderId}");
    paymentFacilitySlot(response.orderId.toString());
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    debugPrint("payment F ${response.message}");
    Get.snackbar("Payment Failed", "Order Id : ${response.message}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
        isBooking = false;
        update();
  }
*/
/*  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    debugPrint("payment W ${response.walletName}");
  }*/

  Future<void> paymentFacilitySlot() async {
    
    var data = {
      "userid": userId.toString(),
      "token": token,
      "partner_id": experiences![0]!.user_id.toString(),
      "amount": tBookingAmt.toString(),
      "booking_user_id": userId.toString(),
      "type": "4", //facilityId.toString(),
      "experience_id": expId,
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
        try{
        ApiService.processorder(datainp).then((respons) async{
          var datinpns = {
            "easepayid": jsonDecode(respons)["data"],
            "order_id": res.order_id.toString(),
            "status": "1",
            "token": token,
            "userid": userId.toString()
          };
         String result = await  easbuzzpayment(datinpns["easepayid"]);
          resonseapi(datinpns, result).then((value) {
            try {
                ApiService.sendBookingNotification(
                    int.parse(experiences![0]!.user_id ?? "0"));
              } catch (e) {
                print(e);
              }
          });
        });
        }
        catch(e)
        {
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

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();
    Map params = Get.parameters;
    var id = params["id"];
    expId = id.toString();
    debugPrint("params $params, id $id ");
    await getExperieceDetails(id);
  }

  Future<void> getExperieceDetails(id) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "id": id.toString()
    };

    await ApiService.getExperienceDetails(data).then((response) {
      ExperienceDetails? res = experienceDetailsFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");

        experiences!.addAll(res.data!);
        if (experiences!.isNotEmpty) {
          tName = experiences![0]!.title!;
          tDescription = experiences![0]!.description!;
          tAdd = experiences![0]!.address.toString();
          //:
          // "";
          tDateTime = experiences![0]!.time.toString();
          tBookingAmt = experiences![0]!.price.toString();
          image = experiences![0]!.image;
          //venueAvail = venues![0]!.weekDays!;
          //   if (venues![0]!.amenitiesDetails != null &&
          //       venues![0]!.amenitiesDetails!.isNotEmpty) {
          //     for (var i = 0; i < venues![0]!.amenitiesDetails!.length; i++) {
          //       amenities!
          //           .add(venues![0]!.amenitiesDetails![i]!.name!.toString());
          //     }
          //   }
        }
        debugPrint(" experiences ${experiences!.length},  ");
        update();
      } else {
        debugPrint("IN hEEre3");
        Get.snackbar("Error", "${res.message}");
      }
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
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
    return result;
  }

  Future resonseapi(Map data, String result) async{
    // print(datinpns);
    try{
      if(result == "payment_successfull")
      {
    await ApiService.responseorder(data).then((respons) {
      Get.snackbar("Payment Sucessful", "Slot booked successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
       Future.delayed(Duration(milliseconds: 10), () {
            Get.offNamedUntil(AppPages.HOME,ModalRoute.withName('/home') );
          });
    });
      }
      else
      {
        Get.snackbar("Payment Error", "Couldnt Process Payment",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      }
  }
  catch(e)
  {
    Get.snackbar("Payment Error", result,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
  }
}
}