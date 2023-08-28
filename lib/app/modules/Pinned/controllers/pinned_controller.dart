import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/facility_payment_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/tournament/models/LikedTournamentResponse.dart' as a;
import 'package:tida_customer/app/modules/tournament/models/LikedTournamentResponse.dart';
import 'package:tida_customer/app/modules/tournament/models/tournament_list_reponse.dart';
import 'package:tida_customer/app/routes/app_pages.dart';

class PinnedController extends GetxController
{
String? userId, userName, token;
  List<Datum?>? tournaments = List.empty(growable: true);
  String? tName = "", tDescription = "", tAdd = "", tAvail = "";
  List<String>? amenities = List.empty(growable: true);
  String? tournamentId = "";
  var fhsl;
  String? tDateTime = "", tBookingAmt = "", image = "", url = "";

  bool isLoading = false;

  bool? isBooking = true;
  RxBool isPinned = false.obs;
  List<a.Tournaments> likedTournament = List.empty(growable: true);

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> paymentFacilitySlot(orderId) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      //"partner_id": "3",
      "amount": tBookingAmt.toString(),
      "booking_user_id": userId.toString(),
      "type": "3", //facilityId.toString(),
      "tournament_id": tournamentId,
      "payment_status": "paid",
      "transaction_type": "1",
      "transaction_id": "",
      "transaction_ticket_id": ""
    };
    debugPrint("v1 data 2 $data");
    await ApiService.paymentBookFacilitySlots(data).then((response) {
      debugPrint("v1 data 2 res $response");
      FacilityPaymentResModel? res = facilityPaymentResModelFromJson(response);
      debugPrint("IN hEEre1");
      if (res.status!) {
        debugPrint("IN hEEre");
        Get.snackbar("Payment Success", "Order Id : $orderId",
            backgroundColor: Colors.lightGreen,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed(AppPages.HOME);
      } else {
        debugPrint("IN hEEre3");
        isBooking = false;
        update();
        //Get.snackbar("Error", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
      isBooking = false;
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
    tournamentId = id.toString();
    debugPrint("params $params, id $id ");
    fetchLikedTournaments();
  }

  Future<void> getTournamentDetails(id) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "id": id.toString(),
    };

    await ApiService.getTournamentsDetails(data).then((response) {
      TournamentList? res = tournamentListFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");

        tournaments!.addAll(res.data!);
        if (tournaments!.isNotEmpty) {
          tName = tournaments![0]!.title!;
          tDescription = tournaments![0]!.description!;
          tAdd = tournaments![0]!.academyDetails!.isNotEmpty
              ? tournaments![0]!.academyDetails![0]!.address
              : "";
          tDateTime = tournaments![0]!.startDate.toString();
          tBookingAmt = tournaments![0]!.price.toString();
          image = tournaments![0]!.image;
          url = tournaments![0]!.url;
          isPinned.value =
              tournaments![0]!.is_like.toString() == "1" ? true : false;
        }

        debugPrint(" tournaments ${tournaments!.length},  ");
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
    isLoading = false;
  }

  Future<void> markUnmarkTournament() async {
    Map params = Get.parameters;
    var id = params["id"];
    var data = {
      "userid": userId.toString(),
      "token": token,
      "type": '3',
      "is_like": isPinned.value ? "1" : "0",
      "post_id": id.toString()
    };

    await ApiService.markUnmarkTournament(data).then((response) {
      print(data);
      debugPrint("IN hEEre1${jsonEncode(response.body)}");

      /*  if (response.body!) {


      } else {
        debugPrint("IN hEEre3");
        Get.snackbar("Error", "${res.message}");
      }*/
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      isLoading = false;
      update();
    });
    isLoading = false;
  }

  Future<void> fetchLikedTournaments() async {
    // Map params = Get.parameters;
    // var id = params["id"];
    var data = {
      "userid": userId.toString(),
      "token": token,
      "type": '3',
      "post_id": "18"
    };
    isLoading = true;
    likedTournament?.clear();
    update();
    await ApiService.fetchLikedTournaments(data).then((response) {
      // print(data);
      // debugPrint("IN hEEre1${jsonDecode(response.body)}");
      print(jsonDecode(response.body)["data"]);
       fhsl = jsonDecode(response.body)["data"]["tournaments"].toString();
      debugPrint(fhsl);
      LikeResponseModel res =
          LikeResponseModel.fromJson(jsonDecode(response.body));
          print(res.data!.tournaments![0].academyId);
      if (res.status== true) {
          // print(jsonDecode(response.body)["data"]["tournaments"][0]["is_like"]);
        likedTournament.addAll(res.data?.tournaments ?? []);
      }

      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      isLoading = false;
      update();
    });
    isLoading = false;
  }
}