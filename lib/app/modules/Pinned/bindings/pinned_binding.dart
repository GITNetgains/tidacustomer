import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Pinned/controllers/pinned_controller.dart';

class PinnedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PinnedController>(
      () => PinnedController(),
    );
  }
}
