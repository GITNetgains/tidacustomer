import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Booking/controllers/orders_controller.dart';
import 'package:tida_customer/app/modules/orders/views/order_details.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';

import '../model/AllOrdersResponse.dart';

class Bookings extends StatelessWidget {
  Bookings({Key? key}) : super(key: key);
  final _c = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.9),
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineLarge("Bookings", color: Colors.white),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return _c.fetchOrders();
            },
            child: Container(
              child: Obx(() => _c.loading.value
                  ? showLoader(
                      hwidth: 80,
                      hheight: 80,
                      asset: "assets/animations/loading_anim.gif")
                  : (_c.orderList.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _c.orderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Data d = _c.orderList[index];
                            return InkWell(
                              onTap: () {
                                _c.index(index);
                                Get.to(() => OrderDetails());
                              },
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _getInfo("Order Id", d.id ?? ""),
                                              _getInfo("Order Type",
                                                  '${_getOrderType(d.type ?? "")}'),
                                              _getInfo(
                                                  "Order Status",
                                                  (d.status == "1"
                                                      ? "Completed"
                                                      : "Pending")),
                                              _getInfo(
                                                  "Amount",
                                                  (d.amount != null)
                                                      ? "₹${d.amount}"
                                                      : "-"),
                                              _getInfo(
                                                  "Date",
                                                  getFormattedDate1(
                                                      d.orderDate ?? "")),
                                              _getInfo(
                                                  "Time",
                                                  getFormattedTime(
                                                          d.orderDate ?? "")
                                                      .toUpperCase()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: setMediumLabel(
                              "No order available. Please check back later."),
                        ))),
            ),
          ));
  }

  _getOrderType(String type) {
//type: 1-venue/facility,2-academy/session,3-tournament,4-experience
    switch (type) {
      case "1":
        return "Facility Slot";

      case "2":
        return "Academy Session";
      case "3":
        return "Tournament";
      case "4":
        return "Experience";

      default:
        return "N/A";
    }
  }

  _getInfos(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 10.0),
      child: SizedBox(
        width: MediaQuery.of(Get.context!).size.width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            setMediumLabel(title, color: Colors.black),
            getHorizontalSpace(),
            Expanded(
                child: setMediumLabel(value.capitalizeFirst!,
                    color: PRIMARY_COLOR)),
          ],
        ),
      ),
    );
  }

  Widget _getInfo(String lbl, String value) {
    if (value.isEmpty) {
      return Container();
    }

    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width * 0.2,
              child: setCardHeading('$lbl:',
                  fontSize: SMALL_FONT, color: Colors.red),
            ),
            const SizedBox(
              width: 5,
            ),
            setMediumLabel(value.capitalize!,
                fontSize: SMALL_FONT, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
