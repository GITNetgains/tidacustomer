import 'package:get/get.dart';
import 'package:tida_customer/app/modules/tnc/controllers/tnc_controller.dart';

class TNCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TNCController>(
      () => TNCController(),
    );
  }
}
