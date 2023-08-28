import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Home/controllers/home_controller.dart';
import 'package:tida_customer/app/modules/search/controllers/search_controller.dart';

class FilterSearchController extends GetxController
{
    final searchScreenCtrl = Get.find<SearchScreenController>();
  final homeCtrl = Get.find<HomeController>();
  List<String> tags = []; //['Venue', 'Tournament'];
  List<String> options = ['Venue', 'Academy', 'Tournament', "Experience"];
  dynamic initialVal = 10.0;
  String? kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0";
  bool? showLocLoader = false;

  @override
  void onInit() {
    super.onInit();
    if (searchScreenCtrl.tags!.trim().isNotEmpty) {
      tags.clear();
      tags.addAll(searchScreenCtrl.tags!.trim().split(","));
    }
    if (searchScreenCtrl.radius!.trim().isNotEmpty &&
        double.tryParse(searchScreenCtrl.radius!) != null) {
      initialVal = double.tryParse(searchScreenCtrl.radius!);
    }
    update();
  }
}