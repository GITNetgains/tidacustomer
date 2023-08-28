import 'package:get/get.dart';
import 'package:tida_customer/app/modules/change_password/controllers/change_password_vm.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(),
    );
  }
}
