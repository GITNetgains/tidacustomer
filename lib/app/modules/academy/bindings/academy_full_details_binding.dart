import 'package:get/get.dart';
import 'package:tida_customer/app/modules/academy/controllers/academy_full_details_controller.dart';

class AcademyFullDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcademyFullDetailsController>(
      () => AcademyFullDetailsController(),
    );
  }
}
