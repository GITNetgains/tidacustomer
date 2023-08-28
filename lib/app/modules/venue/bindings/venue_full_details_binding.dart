import 'package:get/get.dart';
import 'package:tida_customer/app/modules/sports/controllers/sports_controller.dart';
import 'package:tida_customer/app/modules/venue/controllers/venue_details_controller.dart';

class VenueFullDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueFullDetailsController>(
      () => VenueFullDetailsController(),
    );
  }
}
