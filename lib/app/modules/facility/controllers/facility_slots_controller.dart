import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/facility_payment_model.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/facility/models/fetch_facility_slots_model.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/app/modules/facility/models/facility_booking_model.dart'
    as book;
import 'package:booking_calendar/booking_calendar.dart';

class FacilitySlotsController extends GetxController {
  static MethodChannel channel = MethodChannel('easebuzz');
  String? userId, userName, token;
  List<Datum?>? slots = List.empty(growable: true);
  bool? isLoading = true, hasCallSupport = false;
  String? facilityId;
  String? facilityname;
  String? partner_id;
  final now = DateTime.now();
  BookingService? bookingService;
  List<DateTimeRange> converted = [];
  DateTime? bookingStart;
  DateTime? bookingEnd;
  String? selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime? selectedDateTime = DateTime.now();
  String? amt = "0";
  String? slotId = "";
  int selectedSlot = -1;
  bool? isBooking = false;
  String? venueid;

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();
    Map params = Get.parameters;
    partner_id = params["partner_id"];
    var id = params["id"];
    facilityId = id.toString();
    facilityname = params["title"];
    // amt = "2"; 
    amt = params["amt"].toString();
    venueid = params["venue_id"].toString();
    debugPrint("params $params, id $id ");

    await getFacilitySlots();
    // print(getFacilitySlots());
    isLoading = false;
    update();
  }

  Stream<dynamic>? getBookingStream(
      {required DateTime end, required DateTime start}) {
    debugPrint(
        "In getBooking Stream ${end.toIso8601String()}, ${start.toIso8601String()}");
    selectedDate = DateFormat("yyyy-MM-dd").format(start);
    selectedDateTime = start;
    getFacilitySlots();
    return Stream.value([]);
  }

  Future<dynamic> uploadBooking({required BookingService newBooking}) async {
    String? startTime =
        newBooking.bookingStart.toString(); //.substring(11, 19);
    String? endTime = newBooking.bookingEnd.toString(); //.substring(11, 19);
    bookFacilitySlot(startTime, endTime, facilityId);
  }

  List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
    debugPrint("In convertStreamResult");
    if (slots!.isNotEmpty) {
      for (var i = 0; i < slots!.length; i++) {
        if (slots![i]!.slotBookingStatus == 1 ||
            slots![i]!.slotBlockStatus == 1) {
          DateTime start = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![i]!.slotStartTime}");
          DateTime end = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![i]!.slotEndTime}");
          converted.add(DateTimeRange(start: start, end: end));
        }
      }
    }

    return converted;
  }

  Future<void> getFacilitySlots() async {
    isLoading = true;
    update();
    var data = {
      "userid": userId.toString(),
      "token": token,
      "facility_id": facilityId,
      "facility_name": facilityname,
      "date": selectedDate,
      "venue_id": venueid
    };
    debugPrint(data.toString());
    await ApiService.fetchFacilitySlots(data).then((response) {
      FetchSlotsResponseModel? res = fetchSlotsResponseModelFromJson(response);
      if (res.status!) {
        slots!.clear();
        slots!.addAll(res.data ?? []);
        if (slots!.isNotEmpty) {
          bookingStart = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![0]!.slotStartTime}");
          bookingEnd = DateTime.parse(
              "${DateFormat("yyyy-MM-dd").format(selectedDateTime!)} ${slots![slots!.length - 1]!.slotEndTime}");
          bookingService = BookingService(
              serviceName: 'Slot Booking',
              serviceDuration: 30,
              bookingEnd: bookingEnd!,
              bookingStart: bookingStart!);
        }

        // debugPrint(" slots ${slots!.length},  ");
        update();
      } else {
        //Get.snackbar("Error", "${res.message}");
      }
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      print(error);
      Get.snackbar("Error", error.toString());
      isLoading = false;
      update();
    });
  }

  Future<void> bookFacilitySlot(startTime, endTime, facility) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "booking_user_id": userId.toString(),
      "facility_id": facility,
      "date": selectedDate,
      "start_time": startTime,
      "end_time": endTime
    };
    debugPrint("v1 data $data");
    await ApiService.bookFacilitySlots(data).then((response) {
      book.SlotBookingResponseModel? res =
          book.slotBookingResponseModelFromJson(response);
      if (res.status!) {
        slotId = res.data!.isNotEmpty ? res.data![0].id.toString() : null;
        MySharedPref.getemail() == "guest@email.com"
            ? customerlogin()
            : paymentFacilitySlot();
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

  Future<void> paymentFacilitySlot() async {
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
            String result = await easbuzzpayment(datinpns["easepayid"]);
            print(result);
            resonseapi(datinpns, result).then((value) {
              try {
                ApiService.sendBookingNotification(
                    int.parse(partner_id ?? "0"));
              } catch (e) {
                print(e);
              }
            });
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

  Future resonseapi(Map data, String result) async {
    // print(datinpns);
    try {
      if (result == "payment_successfull") {
        await ApiService.responseorder(data).then((respons) {
          Get.snackbar("Sucessful", "Slot booked successfully",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          Future.delayed(Duration(milliseconds: 10), () {
            Get.offNamedUntil(AppPages.HOME, ModalRoute.withName('/home'));
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
}

void customerlogin() {
  Get.snackbar(
      "Login/SignUp", "Please Login/Signup an account to make a booking",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
  //  MySharedPref.clearSession();
  //  Get.offAllNamed(AppPages.INITIAL);
}
