import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/venue/controllers/venue_controllerd.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class VenueListView extends StatelessWidget {
  const VenueListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueController>(builder: (c) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineMedium("Nearby Venues", color: Colors.white),
          ),
          body: RefreshIndicator(
            onRefresh: c.getVenues,
            child: basebody(
              c.isLoading.value!,
              c.venues!.isEmpty
                  ? NoData()
                  : ListView.builder(
                      itemCount: c.venues!.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return venuecard(
                            c.venues[index]!.image.toString(),
                            c.venues[index]!.title.toString(),
                            c.venues[index]!.address.toString(),
                            c.venues[index]!.id.toString());
                      }),
            ),
          ));
    });
  }
}
