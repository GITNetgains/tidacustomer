import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/nearby_search_response.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';

class SportsController extends GetxController {
  List<Academy?>? academies = List.empty(growable: true);
  RxString userid = "".obs;
  RxString authtoken = "".obs;
  RxString radius = "10".obs;
  RxString sport = "".obs;
  RxString sportname = "".obs;
  RxBool showNoData = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    getdata();
  }

  bool? isProperString(String? s) {
    if (s != null &&
        s.toString().trim().isNotEmpty &&
        s.toString().trim() != "null") {
      return true;
    }
    return false;
  }

  Future<void> getdata() async {
    isLoading(true);
    var lati = MySharedPref.getlati();
    var longi = MySharedPref.getlongi();
    sport.value = Get.parameters["id"] ?? "1";
    sportname.value = Get.parameters["name"] ?? "Cricket";
    if (isProperString(lati)!) {
      lati = lati.toString();
    }
    if (isProperString(longi)!) {
      longi = longi.toString();
    }
    var data = {
      "userid": userid.value.toString(),
      "token": authtoken.value,
      "latitude": lati,
      "longitude": longi,
      "distance_km": radius.value!.trim().isNotEmpty ? radius.value! : "100",
      "sport": sport.value.toString()
    };
    ApiService.getSearchBySport(data).then((respnse){
      NearbyDataResponse? res = nearbyDataResponseFromJson(respnse);
      if(res!.status!)
      {
        clearLists();
         academies!.addAll(res.data!.academy!);
         print(academies);
         update();
      }
      else {
        clearLists();
      }
    }).onError((error, stackTrace) {
      clearLists();
      Get.snackbar("Error", error.toString());
    });
    if (academies?.isEmpty?? true) {
      showNoData(true);
    }
    isLoading(false);
  }

  void clearLists() {
    academies!.clear();
  }
}
