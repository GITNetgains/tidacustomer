import 'package:get/get.dart';
import 'package:tida_customer/app/modules/facility/controllers/facility_slots_controller.dart';

class FacilitySlotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacilitySlotsController>(
      () => FacilitySlotsController(),
    );
  }
}
