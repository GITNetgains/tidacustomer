import 'package:get/get.dart';

import 'package:tida_customer/app/modules/filter_search/controller/filter_search_controller.dart';

class FilterSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterSearchController>(
      () => FilterSearchController(),
    );
  }
}
