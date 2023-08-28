import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Pinned/controllers/pinned_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class PinnedView extends StatelessWidget {
  const PinnedView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinnedController>(builder: (c) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineMedium("Library", color: Colors.white),
          ),
          body:
              // Text(c.fhsl)
              RefreshIndicator(
            onRefresh: c.fetchLikedTournaments,
            child: basebody(
              c.isLoading,
              c.likedTournament.isNotEmpty
                  ? ListView(
                      children:
                          List.generate(c.likedTournament.length, (index) {
                        return tournamentcard(
                            c.likedTournament[index]!.image.toString(),
                            c.likedTournament[index].title.toString(),
                            c.likedTournament[index].description.toString(),
                            c.likedTournament[index].id.toString());
                      }),
                    )
                  : Center(
                      child: setMediumLabel("No pinned broadcast available"),
                    ),
            ),
          ));
    });
  }
}
