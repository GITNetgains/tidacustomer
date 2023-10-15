import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/tournament/controllers/tournament_details_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TournamentDetailsView extends StatelessWidget {
  const TournamentDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentDetailsController>(builder: (c) {
      return WillPopScope(
          onWillPop: () async {
            c.isVideoPlaying(false);
            Get.back();
            return false;
          },
          child: Scaffold(
            bottomNavigationBar:
                c.isFullScreen.value ? null : Image.asset("assets/footer.png"),
            appBar: c.isFullScreen.value
                ? null
                : AppBar(
                    backgroundColor: PRIMARY_COLOR,
                    title: setHeadlineMedium("Details", color: Colors.white),
                    actions: [
                      Obx(() => InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            onTap: () {
                              c.isPinned(!c.isPinned.value);
                              c.markUnmarkTournament();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(c.isPinned.value
                                  ? Icons.bookmarks
                                  : Icons.bookmarks_outlined),
                            ),
                          ))
                    ],
                  ),
            body: basebody(
              c.isLoading!,
              c.tournaments!.isEmpty
                  ? NoData()
                  : ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (c.videoController != null)
                                ? Obx(
                                    () => c.isVideoPlaying.value
                                        ? YoutubePlayerBuilder(
                                            player: YoutubePlayer(
                                              controller:
                                                  c.videoController!.value,
                                            ),
                                            builder: (context, player) {
                                              return c.isFullScreen.value ==
                                                      true
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(10.h),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: player)
                                                  : player;
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
                                              getdisplaywidget(
                                                  YoutubePlayer.getThumbnail(
                                                      videoId: YoutubePlayer
                                                          .convertUrlToId(
                                                              c.url!)!)),
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
                                : SizedBox(
                                    height: 180.w,
                                    width: double.infinity,
                                    child: getdisplaywidget(c.image.toString())),
                            Visibility(
                                visible: !c.isFullScreen.value,
                                child: Padding(
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
                                      displayView("Date & Time",
                                          getFormattedDateTime(c.tDateTime!)),
                                      displayView("Venue Details",
                                          getFormattedDateTime(c.tAdd!)),
                                      c.sponserList.isEmpty
                                          ? Container()
                                          : getVerticalSpace(),
                                      c.sponserList.isEmpty
                                          ? Container()
                                          : setCardHeading("Sponsors"),
                                      c.sponserList.isEmpty
                                          ? Container()
                                          : ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              children: List.generate(
                                                  c.sponserList.length,
                                                  (index) => ListTile(
                                                        onTap: () {
                                                          if (c
                                                                  .sponserList[
                                                                      index]
                                                                  .website !=
                                                              null) {
                                                            launchUrlString(c
                                                                .sponserList[
                                                                    index]
                                                                .website!);
                                                          }
                                                        },
                                                        leading: const Icon(
                                                          Icons.sports,
                                                          color: Colors.red,
                                                        ),
                                                        title: setMediumLabel(
                                                            c.sponserList[index]
                                                                    .name ??
                                                                ""),
                                                        subtitle: (c
                                                                        .sponserList[
                                                                            index]
                                                                        .website ??
                                                                    "")!
                                                                .isNotEmpty
                                                            ? setSmallLabel(c
                                                                    .sponserList[
                                                                        index]
                                                                    .website ??
                                                                "")
                                                            : null,
                                                      )),
                                            ),
                                      getVerticalSpace(),
                                      getVerticalSpace(),
/*
                          Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: getSecondaryButton("Watch Now", () {
                                */
/*  if (c.tBookingAmt!.isEmpty) {
                            Get.snackbar("Can't Book", "No price from server");
                          } else {
                            c.isBooking = true;
                            c.update();
                            c.getPaymentInfo();
                          }*/ /*

                                Get.to(() => WebViewScreen(c.url));
                              })),
*/
                                      getVerticalSpace(),
                                      Center(
                                          child: InkWell(
                                              onTap: () {
                                                // Get.toNamed(AppRoutes.tnc);
                                                Get.toNamed(AppPages.TNC);
                                              },
                                              child: setXSmallLabel(
                                                "Terms & Conditions apply",
                                              )))
                                    ],
                                  ),
                                ))
                          ],
                        )
                      ],
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
