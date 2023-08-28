import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/modules/experience/controllers/experience_list_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class ExperienceListView extends StatelessWidget {
  const ExperienceListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExperienceListController>(builder: (c) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineMedium("Experiences", color: Colors.white),
          ),
          body: basebody(
            c.isLoading!,
            c.experiences!.isEmpty
                ? NoData()
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: c.experiences!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return experienceCard(c, index);
                    }),
          ));
    });
  }

  static Widget experienceCard(c, int index) {
    //
    return
        //Column(
        //   children: [
        InkWell(
            onTap: () {
              Get.toNamed(AppPages.EXPERIENCE_DETAILS,
                  parameters: {"id": c.experiences![index]!.id!.toString()});
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              width: 360.w * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5),
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          height: 180.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                            24.0.r,
                          )),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0),
                              ),
                              child: getImagewidget(
                                  c.experiences![index]!.image.toString())),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.0.r),
                          bottomRight: Radius.circular(24.0.r)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCardHeading(c.experiences![index]!.title!),
                              setSmallLabel(c.experiences![index]!.description!,
                                  textOverflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        getHorizontalSpace(),
                        getSecondaryButton("Book Now", () {
                          Get.toNamed(AppPages.EXPERIENCE_DETAILS, parameters: {
                            "id": c.experiences![index]!.id!.toString()
                          });
                        })
                      ],
                    ),
                  ),
                ],
              ),
            )

            // Container(
            //   height: SizeConfig.screenWidth / 2,
            //   margin: const EdgeInsets.only(bottom: 8),
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.transparent, width: 0.5),
            //       borderRadius: BorderRadius.circular(
            //         24.0,
            //       ),
            //       image: DecorationImage(
            //           image: (c.experiences![index]!.image != null &&
            //                   c.experiences![index]!.image!
            //                       .toString()
            //                       .trim()
            //                       .isNotEmpty &&
            //                   c.experiences![index]!.image!.toString().trim() !=
            //                       "null")
            //               ? NetworkImage(
            //                   c.experiences![index]!.image!,
            //                   //"https://img.freepik.com/premium-vector/live-cricket-tournament-match-background_30996-5842.jpg"
            //                 )
            //               : const NetworkImage(
            //                   "https://img.freepik.com/premium-vector/live-cricket-tournament-match-background_30996-5842.jpg"),
            //           fit: BoxFit.cover,
            //           colorFilter: ColorFilter.mode(
            //               pureBlack.withOpacity(0.4), BlendMode.darken))),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: <Widget>[
            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.transparent, width: 0.5),
            //           color: Colors.white,
            //           borderRadius: const BorderRadius.only(
            //               bottomLeft: Radius.circular(24.0),
            //               bottomRight: Radius.circular(24.0)),
            //         ),
            //         padding: const EdgeInsets.all(5),
            //         child: Container(
            //           width: double.infinity,
            //           padding: const EdgeInsets.all(5),
            //           child:
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   setCardHeading(c.experiences![index]!.title!),
            //                   setSmallLabel(c.experiences![index]!.description!),
            //                 ],
            //               ),
            //               getHorizontalSpace(),
            //               getSecondaryButton("Book Now", () {
            //                 Get.toNamed(AppRoutes.experienceDetails, parameters: {
            //                   "id": c.experiences![index]!.id!.toString()
            //                 });
            //               })
            //             ],
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            ) // ),
        ;
    //  getVerticalSpace()
    // ],
    //);
  }
}
