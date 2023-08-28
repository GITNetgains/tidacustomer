import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/tournament/controllers/tournament_list_vm.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class TournamentListView extends StatelessWidget {
  const TournamentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentListController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("Tournaments", color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: c.init,
          child:basebody( c.isLoading!,
              c.tournaments!.isEmpty
                  ? NoData()
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: c.tournaments!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return tournamentcard(c.tournaments![index]!.image.toString(), c.tournaments![index]!.title.toString(), c.tournaments![index]!.description.toString(), c.tournaments![index]!.id.toString());
                      }),
        ),
      ));
    });
  }
}
