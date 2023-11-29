import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tida_customer/app/components/app_bottom_sheet.dart';
import 'package:tida_customer/app/modules/Home/controllers/home_controller.dart';
import 'package:tida_customer/app/modules/Home/views/menu_bar.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/main.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/constants.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool askPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await setupInteractedMessage());

    Future(() {
      return requestNotificationPermissions(context);
    }).then((value) {
      if (!askPermission && !value) {
        // Notification permissions permanently denied, open app settings
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content:
                  const Text('Please enable notifications in app settings.'),
              actions: [
                TextButton(
                  onPressed: () {
                    askPermission = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await openAppSettings()
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return SafeArea(
        child: Scaffold(
          key: c.key,
          drawer: Menubar(c.key),
          appBar: cstappbar(c.name ?? "User", c.key),
          drawerDragStartBehavior: DragStartBehavior.start,
          body: RefreshIndicator(
              onRefresh: c.init,
              child: Padding(
                padding: const EdgeInsets.all(8.0).h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      searchbar(context),
                      locationselection(context),
                      academieshomelist(),
                      sportslist(),
                      tournamentslist(),
                      venueshomelist(),
                      expereincehomelist(),
                      SizedBox(
                        height: 40.h,
                      ),
                      const AppBottomSheet()
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }

  PreferredSize cstappbar(String name, GlobalKey<ScaffoldState> key) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 80.h),
      child: Container(
        padding: const EdgeInsets.all(15).h,
        decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(22.r),
                bottomLeft: Radius.circular(22.r))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0).h,
              child: InkWell(
                onTap: () {
                  key.currentState!.openDrawer();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 1.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
            setHeadlineMedium('Hey, ${name.split(" ").first}',
                color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget locationselection(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return InkWell(
        onTap: () {
          c.handlePressButton(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              c.isLoading == true
                  ? showLoader(
                      hwidth: 80, hheight: 80, asset: AppImages.overallloading)
                  : const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 24,
                        ),
                      ],
                    ),
              getHorizontalSpace(),
              Expanded(
                  child: Row(
                children: [
                  setMediumLabel(
                      (c.city.value?.toString().trim() ?? "").isEmpty
                          ? "Select Location"
                          : c.city.value!,
                      color: Colors.red),
                  (c.city.value?.toString().trim() ?? "").isEmpty
                      ? Container()
                      : setSmallLabel(" (Edit) ", color: Colors.black)
                ],
              )),
            ],
          ),
        ),
      );
    });
  }

  Widget searchbar(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPages.SEARCH_SCREEN);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0).h,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: PRIMARY_COLOR)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: PRIMARY_COLOR,
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Search",
                          fillColor: Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: const Padding(
                      padding: EdgeInsets.all(11.0),
                      child: Icon(
                        Icons.filter_list_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget academieshomelist() {
    return GetBuilder<HomeController>(builder: (c) {
      return Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, left: 8.0.w, right: 8.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              setHeadlineMedium("Nearby Academies"),
              c.academies!.isEmpty
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.ACADEMY_LIST);
                      },
                      child: setHeadlineMedium("See All",
                          color: PRIMARY_COLOR, fontSize: SMALL_FONT))
            ],
          ),
        ),
        c.academies!.isEmpty
            ? SizedBox(
                height: 50.h,
                child: Center(
                    child: setXSmallLabel("There are no academies nearby.")),
              )
            : Container(
                height: 257.h,
                child: ListView.builder(
                    // shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: c.academies!.length,
                    itemBuilder: (context, index) {
                      return academyCard(
                          c.academies![index]!.logo.toString(),
                          c.academies![index]!.name.toString(),
                          c.academies![index]!.address.toString(),
                          c.academies![index]!.id.toString());
                    }),
              )
      ]);
    });
  }

  Widget tournamentslist() {
    return GetBuilder<HomeController>(builder: (c) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                setHeadlineMedium("School Showcase"),
                c.tournamentslist!.isEmpty
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.TOURNAMENT_LIST);
                        },
                        child: setHeadlineMedium("See All",
                            color: PRIMARY_COLOR, fontSize: SMALL_FONT))
              ],
            ),
          ),
          c.tournamentslist!.isEmpty
              ? SizedBox(
                  height: 50.h,
                  child: Center(
                      child: setXSmallLabel(
                          "There are no popular tournaments now.")),
                )
              : Container(
                  height: 277.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: c.tournamentslist!.length,
                      itemBuilder: (context, index) {
                        return tournamentcard(
                            c.tournamentslist![index]!.image.toString(),
                            c.tournamentslist![index]!.title.toString(),
                            c.tournamentslist![index]!.description.toString(),
                            c.tournamentslist![index]!.id.toString());
                      }),
                ),
        ],
      );
    });
  }

  Widget sportslist() {
    return GetBuilder<HomeController>(builder: (c) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                setHeadlineMedium("Popular Sports"),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: c.sportslist!.isEmpty
                ? SizedBox(
                    height: 50.h,
                    child: Center(
                        child: setXSmallLabel("There are no popular sports.")),
                  )
                : Row(
                    children: List.generate(c.sportslist!.length, (index) {
                    return sportsCard(
                        c.sportslist![index]!.id.toString(),
                        c.sportslist![index]!.sportName.toString(),
                        c.sportslist![index]!.sportIcon.toString());
                  })),
          ),
        ],
      );
    });
  }

  Widget venueshomelist() {
    return GetBuilder<HomeController>(builder: (c) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                setHeadlineMedium("Book a Venue"),
                c.venueshomelist!.isEmpty
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.VENUE_LIST);
                        },
                        child: setHeadlineMedium("See All",
                            color: PRIMARY_COLOR, fontSize: SMALL_FONT))
              ],
            ),
          ),
          c.venueshomelist!.isEmpty
              ? SizedBox(
                  height: 50.h,
                  child: Center(
                      child: setXSmallLabel("There are no venues nearby.")),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(Get.context!).size.width / 2.5,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: c.venueshomelist!.length,
                        itemBuilder: (context, index) {
                          return venuecard(
                              c.venueshomelist![index]!.image.toString(),
                              c.venueshomelist![index]!.title.toString(),
                              c.venueshomelist![index]!.address.toString(),
                              c.venueshomelist![index]!.id.toString());
                        }),
                  ),
                ),
        ],
      );
    });
  }

  Widget expereincehomelist() {
    return GetBuilder<HomeController>(builder: (c) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0.h, left: 8.0.w, right: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                setHeadlineMedium("Nearby workshops & Experiences"),
                c.experienceslist!.isEmpty
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.EXPERIENCE_LIST);
                        },
                        child: setHeadlineMedium("See All",
                            color: PRIMARY_COLOR, fontSize: SMALL_FONT))
              ],
            ),
          ),
          c.experienceslist!.isEmpty
              ? SizedBox(
                  height: 50.h,
                  child: Center(
                      child:
                          setXSmallLabel("There are no experiences nearby.")),
                )
              : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0).r,
                child: SizedBox(
                    height: 257.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: c.experienceslist!.length,
                        itemBuilder: (context, index) {
                          return experincecard(
                              c.experienceslist![index]!.image.toString(),
                              c.experienceslist![index]!.title.toString(),
                              c.experienceslist![index]!.description.toString(),
                              c.experienceslist![index]!.id.toString());
                        }),
                  ),
              ),
        ],
      );
    });
  }
}
