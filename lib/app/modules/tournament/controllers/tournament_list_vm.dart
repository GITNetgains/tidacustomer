import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/tournament/models/tournament_list_reponse.dart';
import 'package:tida_customer/utils/common_utils.dart';


class TournamentListController extends GetxController {
  String? userId, userName, token;
  List<Datum?>? tournaments = List.empty(growable: true);
  List<Datum?>? revtournaments = List.empty(growable: true);
  bool? isLoading = true;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();

    await getTournament();
    isLoading = false;
    update();
  }

  Future<void> getTournament() async {
    var lati = await MySharedPref.getlati();
    var lngi = await MySharedPref.getlongi();
    String lat = "";
    String lng = "";
    if (isProperString(lati)! && isProperString(lngi)!) {
      lat = lati.toString();
      lng = lngi.toString();
    }
    var data = {
      "userid": userId.toString(),
      "token": token,
      "latitude": lat.toString(), // "30.7165768",
      "longitude": lng.toString(), //"76.7440272",
    };
    tournaments?.clear();
    await ApiService.getTournaments(data).then((response) {
      TournamentList? res = tournamentListFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");

        tournaments!.addAll(res.data!);
      tournaments = tournaments!.reversed.toList();
        debugPrint(" tournaments ${tournaments!.length},  ");
        update();
      } else {
        debugPrint("IN hEEre3");
        //Get.snackbar("Error", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
    });
  }
}
