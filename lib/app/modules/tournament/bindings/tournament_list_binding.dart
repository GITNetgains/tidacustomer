import 'package:get/get.dart';

import 'package:tida_customer/app/modules/tournament/controllers/tournament_list_vm.dart';

class TournamentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TournamentListController>(
      () => TournamentListController(),
    );
  }
}
