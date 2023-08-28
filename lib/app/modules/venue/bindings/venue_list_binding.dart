import 'package:get/get.dart';
import 'package:tida_customer/app/modules/sports/controllers/sports_controller.dart';
import 'package:tida_customer/app/modules/venue/controllers/venue_controllerd.dart';

class VenueListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueController>(
      () => VenueController(),
    );
  }
}
