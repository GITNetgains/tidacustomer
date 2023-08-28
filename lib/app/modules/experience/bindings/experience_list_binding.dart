import 'package:get/get.dart';
import 'package:tida_customer/app/modules/experience/controllers/experience_list_controller.dart';

class ExperinceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperienceListController>(
      () => ExperienceListController(),
    );
  }
}
