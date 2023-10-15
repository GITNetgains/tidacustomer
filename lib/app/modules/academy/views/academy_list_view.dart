import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/academy/controllers/academy_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class AcademyListView extends StatelessWidget {
  const AcademyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademyController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("Academies", color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: c.getAcademies,
          child: basebody(
            c.isLoading!.value,
          c.isLoading!.value == false & c.academies!.isEmpty
                ? NoData()
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    itemCount: c.academies!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return academyCard(c.academies![index]!.logo.toString(), c.academies![index]!.name.toString(), c.academies![index]!.description.toString(), c.academies![index]!.id!.toString());
                    }),
          ),
        ),
      );
    });
  }
}
