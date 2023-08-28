import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/app_bottom_sheet.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/academy/controllers/academy_full_details_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class AcademyFullDetailsView extends StatelessWidget {
  const AcademyFullDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademyFullDetailsController>(builder: (c) {
      return Scaffold(
        bottomNavigationBar: AppBottomSheet(),
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("Academy Details", color: Colors.white),
        ),
        body: basebody(
            c.isLoading.value,
            c.academies!.isEmpty
                ? NoData()
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageSlideshow(

                            /// Width of the [ImageSlideshow].
                            width: double.infinity,

                            /// Height of the [ImageSlideshow].
                            height: MediaQuery.of(context).size.width * 0.7,

                            /// The page to show when first creating the [ImageSlideshow].
                            initialPage: 0,

                            /// The color to paint the indicator.
                            indicatorColor: PRIMARY_COLOR,

                            /// The color to paint behind th indicator.
                            indicatorBackgroundColor: Colors.grey,

                            /// Called whenever the page in the center of the viewport changes.
                            onPageChanged: (value) {
                              debugPrint('Page changed: $value');
                            },

                            /// Auto scroll interval.
                            /// Do not auto scroll with null or 0.
                            autoPlayInterval: c.images.length > 1 ? 6000 : 0,

                            /// Loops back to first slide.
                            isLoop: c.images.length > 1,

                            /// The widgets to display in the [ImageSlideshow].
                            /// Add the sample image file into the images folder
                            children: c.isLoading!.value
                                ? [const Center(child: Text("Images Loading"))]
                                : c.images.isNotEmpty
                                    ? List.generate(c.images.length, (index) {
                                        return getImagewidget(
                                            c.images[index].toString());
                                      })
                                    : [
                                        Image.asset(
                                          "assets/img/image_placeholder.jpg",
                                          fit: BoxFit.cover,
                                        )
                                      ]),
                        Padding(
                          padding:  EdgeInsets.only(top:8.h, left: 10.w),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: setHeadlineLarge(
                                        c.acName!.capitalize ?? c.acName!,
                                        color: PRIMARY_COLOR),
                                  ),
                                ],
                              ),
                              // c.actualRating == 0.0
                              //     ? Container()
                              //     : Stack(
                              //         children: [
                              //           RatingBar.builder(
                              //             initialRating: c.actualRating!,
                              //             minRating: 0.0,
                              //             direction: Axis.horizontal,
                              //             allowHalfRating: true,
                              //             itemCount: 5,
                              //             maxRating: 5,
                              //             itemSize: 18,
                              //             itemPadding:
                              //                 const EdgeInsets.symmetric(
                              //                     horizontal: 2.0),
                              //             itemBuilder: (context, _) =>
                              //                 const Icon(
                              //               Icons.star,
                              //               color: Colors.amber,
                              //               size: 8,
                              //             ),
                              //             onRatingUpdate: (rating) {},
                              //           ),
                              //           Positioned.fill(
                              //               child: Container(
                              //             color: Colors.transparent,
                              //           ))
                              //         ],
                              //       ),
                              getVerticalSpace(),
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: 8.0.h, horizontal: 8.w),
                                      child: setMediumLabel(
                                          c.acDescription!.capitalizeFirst ??
                                              c.acDescription!,
                                          align: TextAlign.left),
                                    ),
                                    c.acAdd!.trim().isEmpty
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: [
                                                    displayView(
                                                        "Location", c.acAdd!)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    c.accAvail!.trim().isEmpty
                                        ? Container()
                                        : displayView("Availability",
                                            c.accAvail!.capitalize ?? ""),
                                    displayView("Head Coach",
                                        c.academies?.first?.headCoach ?? ""),
                                    displayView("Skill Level",
                                        c.academies?.first?.skillLevel ?? ""),
                                    displayView(
                                        "Assistant Coach Name",
                                        c.academies?.first?.assistentCoachName ??
                                            ""),
                                    displayView(
                                        "Assist. Coaches",
                                        c.academies?.first?.noOfAssistentCoach ??
                                            ""),
                                    displayView(
                                        "Coach Exp(Years)",
                                        c.academies?.first?.coachExperience ??
                                            ""),
                                    displayView("Flood Lights",
                                        c.academies?.first?.floodLights ?? ""),
                                    /*   displayView(
                                    "Age Group",
                                    _getAgeGroup(c.academies?.first
                                            ?.ageGroupOfStudents ??
                                        "")),*/
                                  ],
                                ),
                              ),

                              c.amenities!.isEmpty
                                  ? Container()
                                  : ChipsChoice<String>.multiple(
                                      wrapped: true,
                                      value: c.tags,
                                      leading: setHeadlineMedium("Amenities"),
                                      onChanged: (val) => debugPrint("vvv"),
                                      choiceItems:
                                          C2Choice.listFrom<String, String>(
                                        source: c.amenities!,
                                        value: (i, v) => v,
                                        label: (i, v) => v,
                                      ),
                                    ),
                              getVerticalSpace(),
                              getVerticalSpace(),
                              c.packages!.isEmpty
                                  ? Column(
                                      children: [
                                        getVerticalSpace(),
                                        Center(
                                          child: setMediumLabel(
                                              "No packages are available for this academy."),
                                        ),
                                        getVerticalSpace(),
                                      ],
                                    )
                                  : setHeadlineLarge("Book a Package"),
                              getVerticalSpace(),
                              getVerticalSpace(),
                              /* c.packages!.isEmpty
                                  ? Container()
                                  : c.isBooking!
                                      ? Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              height: 250,
                                              child: Center(
                                                  child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  CircularProgressIndicator(
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text("Please wait ....")
                                                ],
                                              )),
                                            ))
                                          ],
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                MediaQuery.of(Get.context!)
                                                            .size
                                                            .width <
                                                        360
                                                    ? 1
                                                    : 2,
                                          ),
                                          itemCount: c.packages!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              shadowColor: Colors.grey,
                                              elevation: 5,
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    setCardHeading(c
                                                        .packages![index]!
                                                        .title!
                                                        .toLowerCase()
                                                        .toString()
                                                        .capitalize!),
                                                    getVerticalSpace(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.currency_rupee,
                                                          size: 18,
                                                        ),
                                                        setMediumLabel(
                                                            "${c.packages![index]!.price.toString()} Onwards",
                                                            color:
                                                                Colors.black),
                                                      ],
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.dialog(
                                                            AlertDialog(
                                                              title: setMediumLabel(c
                                                                  .packages![
                                                                      index]!
                                                                  .title
                                                                  .toString()),
                                                              content:
                                                                  setMediumLabel(
                                                                      '${c.packages![index]!.description.toString()}.\nClick on Book now to proceed for payment.'),
                                                              actions: [
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                          "Ok"),
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: setMediumLabel(
                                                            "View Details",
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: Colors.red)),
                                                    getSecondaryButton(
                                                        "Buy Now", () {
                                                      if (c.packages![index]!
                                                          .price!.isNotEmpty) {
                                                        c.bookingAmt = c
                                                            .packages![index]!
                                                            .price
                                                            .toString();
                                                        c.packageId = c
                                                            .packages![index]!
                                                            .id
                                                            .toString();
                                                        c.isBooking = true;
                                                        c.update();
                                                        c.paymentFacilitySlot();
                                                      } else {
                                                        Get.snackbar(
                                                            "Can't Book",
                                                            "No price from server");
                                                      }
                                                      // Get.toNamed(AppRoutes.facility,
                                                      //     parameters: {
                                                      //       "id": c.facilites![index]!.id!.toString(),
                                                      //       "amt": c.facilites![index]!.pricePerSlot.toString()
                                                      //     });
                                                    }),
                                                    // getVerticalSpace(),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                    //   children: [
                                                    //     setMediumLabel("20% Off",
                                                    //         color: PRIMARY_COLOR,
                                                    //         decoration: TextDecoration.underline)
                                                    //   ],
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),*/
                              c.packages!.isEmpty
                                  ? Container()
                                  : c.isBooking.value
                                      ? Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              height: 250,
                                              child: Center(
                                                  child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  CircularProgressIndicator(
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text("Please wait ....")
                                                ],
                                              )),
                                            ))
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: c.packages!.length,
                                          itemBuilder: (context, index) {
                                            var item = c.packages![index];
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(28),
                                                        topRight:
                                                            Radius.circular(28),
                                                        bottomLeft:
                                                            Radius.circular(28),
                                                        bottomRight:
                                                            Radius.circular(
                                                                28)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(
                                                                Get.context!)
                                                            .size
                                                            .width *
                                                        0.88,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          setHeadlineMedium(
                                                              item!.title
                                                                  .toString()
                                                                  .capitalize!,
                                                              color:
                                                                  Colors.red),
                                                          setSmallLabel(item
                                                              .description
                                                              .toString()
                                                              .capitalizeFirst!),
                                                          getVerticalSpace(),
                                                          const Divider(
                                                            color: Colors.red,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  setCardHeading(
                                                                      'Price: ',
                                                                      fontSize:
                                                                          15),
                                                                  setMediumLabel(
                                                                      '₹${item!.price.toString()}/-',
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black)
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  getSecondaryButton(
                                                                    'Book Now',
                                                                    () {
                                                                      if (c
                                                                          .packages![
                                                                              index]!
                                                                          .price!
                                                                          .isNotEmpty) {
                                                                        c.bookingAmt = c
                                                                            .packages![index]!
                                                                            .price
                                                                            .toString();
                                                                        c.packageId.value = c
                                                                            .packages![index]!
                                                                            .id
                                                                            .toString();
                                                                        c.isBooking.value =
                                                                            true;
                                                                        c.update();
                                                                        c.paymentFacilitySlot();
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  //    const Icon(Icons.arrow_forward_ios_rounded)
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                              getVerticalSpace(),
                              getVerticalSpace(),
                              getFooter(c.lat, c.lng),
                              getVerticalSpace(),
                              Center(
                                  child: InkWell(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.tnc);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: setXSmallLabel(
                                    "Terms & Conditions apply",
                                  ),
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
      );
    });
  }

  Widget displayView(String lbl, String value) {
    if (value.isEmpty) {
      return Container();
    }

    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      child: Padding(
        padding:  EdgeInsets.only(top: 8.0.h, left: 10.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(Get.context!).size.width * 0.23,
                child: setCardHeading('$lbl:', fontSize: 13.sp),
              ),
               SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: MediaQuery.of(Get.context!).size.width * 0.7,
                child: setMediumLabel(value.capitalize!,
                    fontSize: 13.sp, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
