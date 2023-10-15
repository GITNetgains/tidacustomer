import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/modules/experience/controllers/experience_details_controller.dart';
import 'package:tida_customer/app/modules/facility/controllers/facility_slots_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

import '../../../routes/app_pages.dart';

class ExperienceDetailsView extends StatelessWidget {
  const ExperienceDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExperienceDetailsController>(builder: (c) {
      return Scaffold(
          bottomNavigationBar: Image.asset("assets/footer.png"),
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineMedium("Details", color: Colors.white),
          ),
          body: basebody(
            c.isLoading!,
            c.experiences!.isEmpty
                ? NoData()
                : ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 180.w,
                        width: double.infinity,
                        child: ClipRRect(
                          child: getdisplaywidget(c.image.toString()),
                        ),
                      ),
                      // (c.image != null &&
                      //           c.image!.toString().trim().isNotEmpty &&
                      //           c.image!.toString().trim() != "null")
                      //       ? Image.network(
                      //           c.image!,
                      //           height: SizeConfig.screenWidth / 2,
                      //           width: double.infinity,
                      //           fit: BoxFit.fitWidth,
                      //           // width: SizeConfig.screenWidth / 6,
                      //           // height: SizeConfig.screenWidth / 6,
                      //           // fit: BoxFit.fill,
                      //         )
                      //       : Image.network(
                      //           "https://images.indianexpress.com/2020/05/Chandigarh-Golf-Club1-759.jpg",
                      //           height: SizeConfig.screenWidth / 2,
                      //           width: double.infinity,
                      //           fit: BoxFit.fitWidth,
                      //           // width: SizeConfig.screenWidth / 6,
                      //           // height: SizeConfig.screenWidth / 6,
                      //           // fit: BoxFit.fill,
                      //         ),
                      // Image.network(
                      //   "https://t3.ftcdn.net/jpg/04/28/40/40/360_F_428404007_dlbIe8jNte0Td6fzJ5NIVoLGcAP0drQ6.jpg",
                      //   height: SizeConfig.screenWidth / 2,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: setHeadlineLarge(c.tName!,
                                        color: PRIMARY_COLOR)),
                              ],
                            ),
                            getVerticalSpace(),
                            setMediumLabel(c.tDescription!),
                            getVerticalSpace(),
                            getVerticalSpace(),
                            c.tDateTime!.trim().isEmpty
                                ? Container()
                                : Row(
                                    children: [
                                      setHeadlineMedium("Date & Time:"),
                                      getHorizontalSpace(),
                                      setHeadlineMedium(
                                          getFormattedDateTime(c.tDateTime!),
                                          color: Colors.grey),
                                    ],
                                  ),
                            c.tAdd!.trim().isEmpty
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      setHeadlineMedium("Venue Details:"),
                                      getHorizontalSpace(),
                                      Flexible(
                                          child: setHeadlineMedium(c.tAdd!,
                                              color: Colors.grey)),
                                    ],
                                  ),
                            c.tBookingAmt!.trim().isEmpty
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      setHeadlineMedium("Price:"),
                                      getHorizontalSpace(),
                                      Flexible(
                                          child: setHeadlineMedium(
                                              '₹${c.tBookingAmt!}/-',
                                              color: Colors.black)),
                                    ],
                                  ),
                            getVerticalSpace(),
                            getVerticalSpace(),
                            getVerticalSpace(),
                            c.isBooking!
                                ? Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 50,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.red,
                                        )),
                                      ))
                                    ],
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: MySharedPref.getemail() ==
                                            "guest@email.com"
                                        ? getSecondaryButton('Book Now', () {
                                            customerlogin();
                                          })
                                        : getSecondaryButton("Book Now", () {
                                            if (c.tBookingAmt!.isEmpty) {
                                              Get.snackbar("Can't Book",
                                                  "No price from server");
                                            } else {
                                              c.isBooking = true;
                                              c.update();
                                              c.paymentFacilitySlot();
                                            }
                                          })),
                            getVerticalSpace(),
                            Center(
                                child: InkWell(
                                    onTap: () {
                                      // Get.toNamed(AppRoutes.tnc);
                                      Get.toNamed(AppPages.TNC);
                                    },
                                    child: setXSmallLabel(
                                      "Terms & Conditions apply",
                                    ))),
                            Container(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ));
    });
  }
}
