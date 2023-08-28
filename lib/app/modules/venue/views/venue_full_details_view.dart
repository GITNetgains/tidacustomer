import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/venue/controllers/venue_details_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VenueFullDetailsView extends StatelessWidget {
  const VenueFullDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueFullDetailsController>(builder: (c) {
      return WillPopScope(
          onWillPop: () async {
            c.isVideoPlaying(false);
            Get.back();
            return false;
          },
          child: Scaffold(
            bottomNavigationBar: Obx(() => Visibility(
                visible: !c.isFullScreen.value,
                child: Image.asset("assets/footer.png"))),
            appBar: !c.isFullScreen.value
                ? AppBar(
                    backgroundColor: PRIMARY_COLOR,
                    title:
                        setHeadlineMedium("Venue Details", color: Colors.white),
                  )
                : null,
            body: SingleChildScrollView(
              child: basebody(
                c.isLoading!,
                c.venues!.isEmpty
                    ? NoData()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Visibility(
                                visible: !c.isFullScreen.value,
                                child: ImageSlideshow(

                                    /// Width of the [ImageSlideshow].
                                    width: double.infinity,

                                    /// Height of the [ImageSlideshow].
                                    height:
                                        MediaQuery.of(context).size.width * 0.7,

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
                                    autoPlayInterval: 6000,

                                    /// Loops back to first slide.
                                    isLoop: true,

                                    /// The widgets to display in the [ImageSlideshow].
                                    /// Add the sample image file into the images folder
                                    children: c.isLoading!
                                        ? [
                                            const Center(
                                                child: Text("Images Loading"))
                                          ]
                                        : c.images.isNotEmpty
                                            ? List.generate(c.images.length,
                                                (index) {
                                                return getImagewidget(
                                                    c.images[index].toString());
                                              })
                                            : [
                                                Image.asset(
                                                  "assets/img/image_placeholder.jpg",
                                                  fit: BoxFit.cover,
                                                )
                                              ]),
                              )),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Obx(() => Visibility(
                                  visible: !c.isFullScreen.value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: setHeadlineLarge(
                                                  c.venueName!,
                                                  color: PRIMARY_COLOR),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // c.actualRating == 0
                                        //     ? Container()
                                        //     : Stack(
                                        //         children: [
                                        //           RatingBar.builder(
                                        //             initialRating:
                                        //                 c.actualRating!,
                                        //             minRating: 0.0,
                                        //             direction: Axis.horizontal,
                                        //             allowHalfRating: true,
                                        //             itemCount: 5,
                                        //             maxRating: 5,
                                        //             itemSize: 18,
                                        //             itemPadding:
                                        //                 const EdgeInsets
                                        //                         .symmetric(
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
                                        setMediumLabel(c.venueDescription!,
                                            align: TextAlign.left),
                                        // getVerticalSpace(),
                                        c.venueAdd!.trim().isEmpty
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      children: [
                                                        displayView("Location",
                                                            c.venueAdd!),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        getVerticalSpace(),
                                      ],
                                    ),
                                  ))),
                              (c.videoController != null)
                                  ? Obx(
                                      () => c.isVideoPlaying.value
                                          ? YoutubePlayerBuilder(
                                              player: YoutubePlayer(
                                                controller:
                                                    c.videoController!.value,
                                              ),
                                              builder: (context, player) {
                                                return Column(
                                                  children: [player],
                                                );
                                              },
                                              onEnterFullScreen: () {
                                                c.isFullScreen(true);
                                                c.update();
                                              },
                                              onExitFullScreen: () {
                                                c.isFullScreen(false);
                                                c.update();
                                              })
                                          : Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                getImagewidget(
                                                  YoutubePlayer.getThumbnail(
                                                      videoId: YoutubePlayer
                                                          .convertUrlToId(c
                                                              .videoUrl
                                                              .value!)!),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    c.isVideoPlaying(true);
                                                  },
                                                  child: const Align(
                                                    alignment: Alignment.center,
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.play_circle,
                                                          color: Colors.red,
                                                          size: 70,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                    )
                                  : Container(),
                              Obx(() => Visibility(
                                    visible: !c.isFullScreen.value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          c.venueAvail!.trim().isEmpty
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    setCardHeading(
                                                        "Availability:",
                                                        fontSize: 15),
                                                    getHorizontalSpace(),
                                                    setHeadlineMedium(
                                                        c.venueAvail!)
                                                  ],
                                                ),
                                          c.amenities!.isEmpty
                                              ? Container()
                                              : ChipsChoice<String>.multiple(
                                                  wrapped: true,
                                                  leading: setCardHeading(
                                                      "Amenities",
                                                      fontSize: 15),
                                                  value: c.amenities!,
                                                  onChanged: (val) =>
                                                      debugPrint("vvv"),
                                                  choiceItems: C2Choice
                                                      .listFrom<String, String>(
                                                    source: c.amenities!,
                                                    value: (i, v) => v,
                                                    label: (i, v) =>
                                                        v.capitalizeFirst ?? "",
                                                  ),
                                                ),
                                          c.selectedSports!.isEmpty
                                              ? Container()
                                              : ChipsChoice<String>.multiple(
                                                  wrapped: true,
                                                  leading: setCardHeading(
                                                      "Sports     ",
                                                      fontSize: 15),
                                                  value: c.selectedSports!,
                                                  onChanged: (val) =>
                                                      debugPrint("vvv"),
                                                  choiceItems: C2Choice
                                                      .listFrom<String, String>(
                                                    source: c.selectedSports!,
                                                    value: (i, v) => v,
                                                    label: (i, v) =>
                                                        v.capitalizeFirst ?? "",
                                                  ),
                                                ),
                                          getVerticalSpace(),
                                          getVerticalSpace(),
                                          c.facilites!.isEmpty
                                              ? Column(
                                                  children: [
                                                    getVerticalSpace(),
                                                    Center(
                                                      child: setMediumLabel(
                                                          "No slots available for this facility."),
                                                    ),
                                                    getVerticalSpace(),
                                                  ],
                                                )
                                              : setHeadlineLarge("Book a Slot"),
                                          getVerticalSpace(),
                                          c.facilites!.isEmpty
                                              ? Container()
                                              : /*GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: MediaQuery.of(
                                                                    Get.context!)
                                                                .size
                                                                .width <
                                                            360
                                                        ? 1
                                                        : 2,
                                                  ),
                                                  itemCount: c.facilites!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Card(
                                                      shadowColor: Colors.grey,
                                                      elevation: 5,
                                                      color: Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            setCardHeading(c
                                                                .facilites![
                                                                    index]!
                                                                .title
                                                                .toString()),
                                                            getVerticalSpace(),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .currency_rupee,
                                                                  size: 18,
                                                                ),
                                                                setMediumLabel(
                                                                    "${c.facilites![index]!.pricePerSlot.toString()} Onwards",
                                                                    color: Colors
                                                                        .grey),
                                                              ],
                                                            ),
                                                            getVerticalSpace(),
                                                            getVerticalSpace(),
                                                            getSecondaryButton(
                                                                "Book Now", () {
                                                              Get.toNamed(
                                                                  AppRoutes
                                                                      .facility,
                                                                  parameters: {
                                                                    "id": c
                                                                        .facilites![
                                                                            index]!
                                                                        .id!
                                                                        .toString(),
                                                                    "amt": c
                                                                        .facilites![
                                                                            index]!
                                                                        .pricePerSlot
                                                                        .toString()
                                                                  });
                                                            }),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })*/

                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  itemCount:
                                                      c.facilites!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item =
                                                        c.facilites![index];
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            topLeft: Radius
                                                                .circular(28),
                                                            topRight:
                                                                Radius.circular(
                                                                    28),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    28),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    28)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              AppPages
                                                                  .FACILITY_SLOTS,
                                                              parameters: {
                                                                "partner_id": c
                                                                    .venues![0]!
                                                                    .userId
                                                                    .toString(),
                                                                "id": c
                                                                    .facilites![
                                                                        index]!
                                                                    .id!
                                                                    .toString(),
                                                                "amt": c
                                                                    .facilites![
                                                                        index]!
                                                                    .pricePerSlot
                                                                    .toString(),
                                                                "title": c
                                                                    .facilites![
                                                                        index]!
                                                                    .title
                                                                    .toString(),
                                                              });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .calendar_month,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    getHorizontalSpace(),
                                                                    item!.title.toString().length <=
                                                                            15
                                                                        ? setHeadlineMedium(item!
                                                                            .title
                                                                            .toString()
                                                                            .capitalize!)
                                                                        : setHeadlineMedium(
                                                                            "${item!.title.toString().substring(0, 14)}...".capitalize!),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          getVerticalSpace(),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    //    const Icon(Icons.arrow_forward_ios_rounded)
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    setHeadlineMedium(
                                                                        "₹ ${item!.pricePerSlot.toString()}"),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_rounded,
                                                                      color: Colors
                                                                          .red,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                          getVerticalSpace(),
                                          getVerticalSpace(),
                                          getVerticalSpace(),
                                          getFooter(c.lat, c.lng),
                                          getVerticalSpace(),
                                          getVerticalSpace(),
                                          Center(
                                              child: InkWell(
                                                  onTap: () {
                                                    // Get.toNamed(AppRoutes.tnc);
                                                  },
                                                  child: setSmallLabel(
                                                    "Terms & Conditions apply",
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
              ),
            ),
          ));
    });
  }

  Widget displayView(String lbl, String value) {
    if (value.isEmpty) {
      return Container();
    }

    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setCardHeading('$lbl:', fontSize: 15),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: setMediumLabel(value.capitalize!,
                  fontSize: 15, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
