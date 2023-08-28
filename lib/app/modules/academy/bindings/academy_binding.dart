import 'package:get/get.dart';
import 'package:tida_customer/app/modules/academy/controllers/academy_controller.dart';

class AcademyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcademyController>(
      () => AcademyController(),
    );
  }
}
