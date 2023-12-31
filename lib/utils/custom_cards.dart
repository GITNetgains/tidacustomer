import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/constants.dart';

Widget academyCard(String url, String name, String description, String id,
    {double verticalmargin = 5}) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppPages.ACADEMY_FULL_DETAILS, parameters: {"id": id});
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0).h,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: verticalmargin),
          width: MediaQuery.of(Get.context!).size.width * 0.9,
          // height:  MediaQuery.of(Get.context!).size.width/2,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.5.w),
            borderRadius: BorderRadius.circular(
              24.0.r,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: getImagewidget(url)),
              Container(
                padding: const EdgeInsets.all(8.0).h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setHeadlineMedium(name, reduce: true),
                    setSmallLabel(description, reduce: true),
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}

Widget tournamentcard(String url, String name, String description, String id,
    {double verticalmargin = 5}) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppPages.TOURNAMENT_DETAILS, parameters: {"id": id});
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0).h,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: verticalmargin),
          width: MediaQuery.of(Get.context!).size.width * 0.9,
          // height:  MediaQuery.of(Get.context!).size.width/2,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.5.w),
            borderRadius: BorderRadius.circular(
              24.0,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: getImagewidget(url)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 0.5),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0)),
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
                        setCardHeading(name.toString(), max: 1, reduce: true),
                        setSmallLabel(description.toString().capitalize!,
                            textOverflow: TextOverflow.ellipsis,
                            max: 2,
                            reduce: true),
                      ],
                    )),
                    getHorizontalSpace(),
                    getSecondaryButton("Watch Now", () {
                      Get.toNamed(AppPages.TOURNAMENT_DETAILS,
                          parameters: {"id": id});
                    })
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}

Widget experincecard(String url, String name, String description, String id,
    {double verticalmargin = 5}) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppPages.EXPERIENCE_DETAILS, parameters: {"id": id});
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0).h,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: verticalmargin),
          width: MediaQuery.of(Get.context!).size.width * 0.9,
          // height:  MediaQuery.of(Get.context!).size.width/2,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.5.w),
            borderRadius: BorderRadius.circular(
              24.0.r,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: getImagewidget(url)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 0.5),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0)),
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
                        setCardHeading(name.toString().capitalize!,
                            max: 3, reduce: true),
                        setSmallLabel(description.toString(),
                            textOverflow: TextOverflow.ellipsis,
                            max: 1,
                            reduce: true),
                      ],
                    )),
                    getHorizontalSpace(),
                    getSecondaryButton("Book Now", () {
                      Get.toNamed(AppPages.EXPERIENCE_DETAILS,
                          parameters: {"id": id});
                      // Get.toNamed(AppRoutes.tournamentDetails, parameters: {
                      //   "id": c.tournaments![index]!.id!.toString()
                      // });
                    })
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}

Widget sportsimagewidget(
    [String url =
        "https://tidasports.com/secure/uploads/tbl_venue/20230824211450-2023-08-24tbl_venue211448.jpg"]) {
  return Container(
    color: Colors.white,
    child: SizedBox(
      //  height:  MediaQuery.of(Get.context!).size.width/2,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        memCacheHeight: 180,
        memCacheWidth: 180,
        height: 180.h,
        width: 180.w,
        fadeInDuration: const Duration(seconds: 1),
        errorWidget: (context, exception, stacktrace) {
          return Icon(Icons.error);
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Image.asset(
            AppImages.loading,
            height: 180.h,
            width: 180.w,
          );
        },
      ),
    ),
  );
}

Widget getImagewidget(
    [String url =
        "https://tidasports.com/secure/uploads/tbl_venue/20230824211450-2023-08-24tbl_venue211448.jpg"]) {
  return Container(
    color: Colors.white,
    child: SizedBox(
      //  height:  MediaQuery.of(Get.context!).size.width/2,
      child: CachedNetworkImage(
        imageUrl:
            url, //"https://res.cloudinary.com/dnp3cguhl/image/upload/v1692563958/download_d2e6e1ef03.jpg",
        fit: BoxFit.cover,
        memCacheHeight: 500,
        memCacheWidth: 1000,
        height: 180.h,
        width: 500.w,
        fadeInDuration: const Duration(seconds: 1),
        errorWidget: (context, exception, stacktrace) {
          return Icon(Icons.error);
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Image.asset(
            AppImages.loading,
            height: 180.h,
            width: 500.w,
          );
        },
      ),
    ),
  );
}

Widget getdisplaywidget(
    [String url =
        "https://tidasports.com/secure/uploads/tbl_venue/20230824211450-2023-08-24tbl_venue211448.jpg"]) {
  return Container(
    color: Colors.white,
    child: SizedBox(
      //  height:  MediaQuery.of(Get.context!).size.width/2,
      child: CachedNetworkImage(
        imageUrl:
            url, //"https://res.cloudinary.com/dnp3cguhl/image/upload/v1692563958/download_d2e6e1ef03.jpg",
        fit: BoxFit.cover,
        memCacheHeight: 400,
        memCacheWidth: 800,
        height: 180.h,
        width: 500.w,
        fadeInDuration: const Duration(seconds: 1),
        errorWidget: (context, exception, stacktrace) {
          return Icon(Icons.error);
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Image.asset(
            AppImages.loading,
            height: 180.h,
            width: 500.w,
          );
        },
      ),
    ),
  );
}

Widget venuecard(String url, String name, String address, String id) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppPages.VENUE_FULL_DETAILS, parameters: {"id": id});
    },
    child: Container(
      width: MediaQuery.of(Get.context!).size.width * 0.9,
      height: MediaQuery.of(Get.context!).size.width / 2.5,
      margin: const EdgeInsets.only(left: 4, right: 7, top: 4, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(Get.context!).size.width / 2.5,
                height: MediaQuery.of(Get.context!).size.width / 2.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28.r),
                      bottomLeft: Radius.circular(28.r)),
                  child: getvenueimagewidget(url: url),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(28.r)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: setXSmallLabel("Book Slot", color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  setCardHeading(
                    name,
                    max: 2,
                  ),
                  getVerticalSpace(),
                  setSmallLabel(
                    address.toUpperCase(),
                  ),
                  getVerticalSpace(),
                ],
              ),
            ),
          ),
          getHorizontalSpace(),
        ],
      ),
    ),
  );
}

Widget getvenueimagewidget(
    {String url =
        "https://tidasports.com/secure/uploads/tbl_venue/20230824211450-2023-08-24tbl_venue211448.jpg"}) {
  return Container(
    color: Colors.white,
    child: SizedBox(
      //  height:  MediaQuery.of(Get.context!).size.width/2,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        memCacheHeight: 500,
        memCacheWidth: 1000,
        // height: 180.h,
        // width: 500.w,
        fadeInDuration: const Duration(seconds: 1),
        errorWidget: (context, exception, stacktrace) {
          return Icon(Icons.error);
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Image.asset(
            AppImages.loading,
            // height: 180.h,
            // width: 500.w,
          );
        },
      ),
    ),
  );
}

Widget sportsCard(id, name, image) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 08),
    child: InkWell(
        onTap: () {
          debugPrint("ON SP TAPPED");
          Get.toNamed(AppPages.SPORTS, parameters: {"id": id, "name": name});
        },
        child: Container(
          height: 105.0.h,
          width: 100.0.h,
          decoration: BoxDecoration(
            border: Border.all(color: PRIMARY_COLOR),
            borderRadius: BorderRadius.circular(24.0).r,
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0.w, 16.0.h, 0.0.w, 6.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                image == null
                    ? const Icon(
                        Icons.sports_cricket,
                        color: PRIMARY_COLOR,
                      )
                    : SizedBox(
                        width: 50.h,
                        height: 50.h,
                        child: ClipRRect(child: sportsimagewidget(image))),
                //SizedBox(height: 12.0,),
                setSmallLabel(name ?? "Cricket", align: TextAlign.center, )
              ],
            ),
          ),
        )),
  );
}
