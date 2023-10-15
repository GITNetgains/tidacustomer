import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/sports/controllers/sports_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class SportsView extends StatelessWidget {
  const SportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SportsController>(builder: (c) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Image.asset("assets/footer.png"),
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium(
              c.sportname.value.toString().capitalizeFirst!,
              color: Colors.white),
        ),
        body: basebody(
          c.isLoading.value,
          c.showNoData.value
              ? NoData()
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getVerticalSpace(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    List.generate(c.academies!.length, (index) {
                                  return academyCard(
                                      c.academies![index]!.logo.toString(),
                                      c.academies![index]!.name.toString(),
                                      c.academies![index]!.description
                                          .toString(),
                                      c.academies![index]!.id.toString());
                                })),
                                // c.venues!.length == 0 ?
                                // Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                // children:
                                //     List.generate(c.venues!.length, (index) {
                                //   return venuecard(
                                //       c.venues![index]!.image.toString(),
                                //       c.venues![index]!.title.toString(),
                                //       c.venues![index]!.address
                                //           .toString(),
                                //       c.venues![index]!.id.toString());
                                // })) : Container(),
                                // c.experiences!.length == 0 ?
                                // Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                // children:
                                //     List.generate(c.experiences!.length, (index) {
                                //   return experincecard(
                                //       c.experiences![index]!.image.toString(),
                                //       c.experiences![index]!.title.toString(),
                                //       c.experiences![index]!.description
                                //           .toString(),
                                //       c.experiences![index]!.id.toString());
                                // })) : Container(),
                            getVerticalSpace(),
                            getVerticalSpace()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
    ;
  }
}
