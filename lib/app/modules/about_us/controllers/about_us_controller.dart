import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AboutUsController extends GetxController {
  RxString appbartext = "".obs;
  RxString inputtext = "".obs;

  @override
  void onInit() {
    appbartext.value = Get.parameters["appbartext"].toString();
    inputtext.value = Get.parameters["inputtext"].toString();
    super.onInit();
  }
}
