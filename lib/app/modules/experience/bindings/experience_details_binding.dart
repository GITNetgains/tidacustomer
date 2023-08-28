import 'package:get/get.dart';
import 'package:tida_customer/app/modules/experience/controllers/experience_details_controller.dart';

class ExperinceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperienceDetailsController>(
      () => ExperienceDetailsController(),
    );
  }
}
