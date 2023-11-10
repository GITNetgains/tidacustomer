import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Booking/controllers/orders_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';

import '../../../../utils/constants.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({Key? key}) : super(key: key);
  final _c = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: Obx(
              () => _c.selectedBookingId.value == "" || _c.index.value == -1
                  ? setHeadlineLarge("Loading Booking Details",
                      color: Colors.white)
                  : setHeadlineLarge(
                      "Booking Details #${_c.getSelectedOrder().id}",
                      color: Colors.white),
            )),
        body: Obx(
          () => _c.selectedBookingId.value == "" || _c.index.value == -1
              ? showLoader(
                  hwidth: 80, hheight: 80, asset: AppImages.overallloading)
              : _c.loading.value
                  ? showLoader(
                      hwidth: 80, hheight: 80, asset: AppImages.overallloading)
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Name", color: Colors.black),
                              setHeadlineMedium(
                                  '${_c.getSelectedOrder().user?.name ?? ""}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Phone", color: Colors.black),
                              setHeadlineMedium(
                                  '${_c.getSelectedOrder().user?.phone ?? ""}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Partner ID",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  '${_c.getSelectedOrder().partnerId.toString()}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Order Id",
                                  color: Colors.black),
                              setHeadlineMedium('#${_c.getSelectedOrder().id}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Order Status",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  '${(_c.getSelectedOrder().status == "1" ? "Completed" : "Pending")}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Amount Paid",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  _c.getSelectedOrder().amount ?? "-",
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Order Type",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  '${(_getOrderType(_c.getSelectedOrder().type ?? ""))}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        // const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _getBookingWidget(),
                        ),
                        _c.getSelectedOrder().type.toString() == "1"
                            ? const Divider()
                            : Container(),
                        _c.getSelectedOrder().type.toString() == "1"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    setHeadlineMedium("Slot Info",
                                        color: Colors.black),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: setHeadlineMedium(
                                          '${getFormattedDateTime1(_c.getSelectedOrder().facilityBooking!.date.toString())}, ${getFormattedTime1(_c.getSelectedOrder().facilityBooking!.slotStartTime.toString())} - ${getFormattedTime1(_c.getSelectedOrder().facilityBooking!.slotEndTime.toString())}',
                                          color: PRIMARY_COLOR,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        _c.getSelectedOrder().type.toString() == "3"
                            ? const Divider()
                            : Container(),
                        _c.getSelectedOrder().type.toString() == "3"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    setHeadlineMedium("URL :",
                                        color: Colors.black),
                                    TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        // Get.to(() => WebViewScreen(
                                        //     _c.getSelectedOrder().tournament?.url));
                                      },
                                      child: Row(
                                        children: [
                                          setHeadlineMedium("Watch",
                                              color: Colors.red),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Transaction Id",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  '#${_c.getSelectedOrder().transactionId.toString()}',
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Transaction Type",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  (_c.getSelectedOrder().type == "1")
                                      ? "Offline"
                                      : "Online",
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Booking date",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  getFormattedDateTime(
                                      _c.getSelectedOrder().orderDate ?? ""),
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setHeadlineMedium("Order placed",
                                  color: Colors.black),
                              setHeadlineMedium(
                                  getFormattedDateTime(
                                      _c.getSelectedOrder().createdAt ?? ""),
                                  color: PRIMARY_COLOR),
                            ],
                          ),
                        ),
                        const Divider(),
                        (_c
                                    .getSelectedOrder()
                                    .status
                                    .toString()
                                    .toLowerCase() !=
                                "1")
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: getPrimaryButton("Pay Now", () {
                                  _c.getSelectedOrder().type == "Facility Slot"
                                      ? _c.bookFacilitySlot(
                                          _c
                                              .getSelectedOrder()
                                              .facility
                                              ?.openingTime
                                              .toString(),
                                          _c
                                              .getSelectedOrder()
                                              .facility
                                              ?.closingTime
                                              .toString(),
                                          _c
                                              .getSelectedOrder()
                                              .facility
                                              ?.id
                                              .toString(),
                                          _c
                                              .getSelectedOrder()
                                              .facilityBooking
                                              ?.date
                                              .toString(),
                                          _c
                                              .getSelectedOrder()
                                              .partnerId
                                              .toString(),
                                          _c
                                              .getSelectedOrder()
                                              .amount
                                              .toString(),
                                        )
                                      : _c.getSelectedOrder().type ==
                                              "Academy Session"
                                          ?
                                          //  _c.paymentFacilitySlot(_c.getSelectedOrder().partnerId.toString(),_c.getSelectedOrder().amount.toString(),_c.getSelectedOrder().toString());
                                          _c.academyexppayment(
                                              _c
                                                  .getSelectedOrder()
                                                  .academy!
                                                  .id
                                                  .toString(),
                                              _c
                                                  .getSelectedOrder()
                                                  .amount
                                                  .toString(),
                                              _c
                                                  .getSelectedOrder()
                                                  .packages!
                                                  .id
                                                  .toString())
                                          : _c.exppaymentSlot(
                                              _c
                                                  .getSelectedOrder()
                                                  .partnerId!
                                                  .toString(),
                                              _c
                                                  .getSelectedOrder()
                                                  .amount
                                                  .toString(),
                                              _c
                                                  .getSelectedOrder()
                                                  .experience!
                                                  .id
                                                  .toString());
                                  // initPaymentSheet(
                                  //     _c.getSelectedOrder().amount.toString(),
                                  //     _c.getSelectedOrder().id.toString());
                                }))
                            : Container(),
                        (_c
                                    .getSelectedOrder()
                                    .status
                                    .toString()
                                    .toLowerCase() ==
                                "1")
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        setMediumLabel("How did we do?"),
                                        getVerticalSpace(),
                                        getVerticalSpace(),
                                        // Obx(
                                        //   () => Center(
                                        //     child: RatingBar.builder(
                                        //       initialRating: _c.rating.value,
                                        //       minRating: 1,
                                        //       direction: Axis.horizontal,
                                        //       allowHalfRating: true,
                                        //       itemCount: 5,
                                        //       itemPadding:
                                        //           const EdgeInsets.symmetric(
                                        //               horizontal: 4.0),
                                        //       itemBuilder: (context, _) =>
                                        //           const Icon(
                                        //         Icons.star,
                                        //         color: Colors.amber,
                                        //       ),
                                        //       onRatingUpdate: (rating) {
                                        //         _c.rating(rating);
                                        //       },
                                        //     ),
                                        //   ),
                                        // ),
                                        getVerticalSpace(),
                                        getVerticalSpace(),
                                        TextFormField(
                                          controller: _c.reviewController,
                                          decoration: InputDecoration(
                                            hintText:
                                                "I liked this facility because...",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        getVerticalSpace(),
                                        getVerticalSpace(),
                                        getPrimaryButton("Submit", () {
                                          _c.saveRating();
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        getVerticalSpace(),
                        getVerticalSpace(),
                      ],
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

  _getBookingWidget() {
    String displayName = "";
    String displaytiming = "";
    String displayaddress = "";
    if (_c.getSelectedOrder().facility != null) {
      displayName = _c.getSelectedOrder().venuename ?? "-";
      displaytiming =
          "${_c.getSelectedOrder().facility!.openingTime ?? ""} - ${_c.getSelectedOrder().facility!.closingTime ?? ""} ";
      displayaddress = _c.getSelectedOrder().facilityaddress ?? "";
    } else if (_c.getSelectedOrder().tournament != null) {
      displayName = _c.getSelectedOrder().tournament?.title ?? "-";
    } else if (_c.getSelectedOrder().academy != null) {
      displayName = _c.getSelectedOrder().academy?.name ?? "-";
      displayaddress = _c.getSelectedOrder().academy!.address.toString() ?? "";
    } else if (_c.getSelectedOrder().experience != null) {
      displayName = _c.getSelectedOrder().experience?.title ?? "-";
      displayaddress =
          _c.getSelectedOrder().experience!.address.toString() ?? "";
    }

    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0).h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              setHeadlineMedium("Service Name", color: Colors.black),
              Container(
                  width: 150.w,
                  child: setHeadlineMedium('${(displayName)}',
                      color: PRIMARY_COLOR, textAlign: TextAlign.right)),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0).h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              setHeadlineMedium("Service Address", color: Colors.black),
              Container(
                  width: 150.w,
                  child: setHeadlineMedium('${(displayaddress)}',
                      color: PRIMARY_COLOR, textAlign: TextAlign.right)),
            ],
          ),
        ),
      ],
    );
  }
}
