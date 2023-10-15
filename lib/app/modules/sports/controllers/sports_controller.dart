import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/nearby_search_response.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';

class SportsController extends GetxController {
  List<Academy?>? academies = List.empty(growable: true);
  List<Venue?>? venues = List.empty(growable: true);
  List<Experience?>? experiences = List.empty(growable: true);
  RxString userid = MySharedPref.getid().toString().obs;
  RxString authtoken = MySharedPref.getauthtoken().toString().obs;
  RxString radius = "100".obs;
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
    await getdata();
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
        clearLists();
    var data = {
      "userid": userid.value.toString(),
      "token": authtoken.value,
      "latitude": lati,
      "longitude": longi,
      "distance_km": radius.value!.trim().isNotEmpty ? radius.value! : "100",
      "sport": sport.value.toString()
    };
    print(data);
    ApiService.getSearchBySport(data).then((respnse){
      NearbyDataResponse? res = nearbyDataResponseFromJson(respnse);
      if(res!.status!)
      {
         academies!.addAll(res.data!.academy!);
        //  venues!.addAll(res.data!.venue!);
        //  experiences!.addAll(res.data!.experience!);
        //  print(venues);
         print(experiences);
         update();
        //  print(academies);
      showNoData(false);
      }
      // else {
      //   clearLists();
      // }
    }).onError((error, stackTrace) {
      // clearLists();
      Get.snackbar("Error", error.toString());
    });
    if (academies?.isEmpty?? true) {
      showNoData(true);
    }
    isLoading(false);
  }

  void clearLists() {
    academies!.clear();
    // venues!.clear();
    // experiences!.clear();
  }
}
