import 'package:get/get.dart';
import 'package:tida_customer/app/modules/about_us/controllers/about_us_controller.dart';
import 'package:tida_customer/app/modules/facility/controllers/facility_slots_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(
      () => AboutUsController(),
    );
  }
}
