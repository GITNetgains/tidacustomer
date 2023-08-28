// import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Home/controllers/home_controller.dart';
import 'package:tida_customer/app/modules/Pinned/controllers/pinned_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Menubar extends StatelessWidget {
  Menubar(
    this.kDrawerKey, {
    super.key,
  });

  GlobalKey<ScaffoldState> kDrawerKey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppPages.PROFILE);
                kDrawerKey.currentState?.closeDrawer();
              },
              child: UserAccountsDrawerHeader(
                accountName: Text(c.name.toString()),
                accountEmail: Text(c.email.toString()),
                currentAccountPicture: Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60)),
                  //backgroundColor: Colors.white70,
                  //minRadius: 60.0,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        //  color: Colors.white70,
                        borderRadius: BorderRadius.circular(60)),
                    child: ClipOval(
                      child: c.avatar!= null
                          ? Image.network(
                              c.avatar.toString() ?? "",
                              width: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, dynamic stackTrace) {
                                return Container(
                                    color: Colors.red.withOpacity(0.1),
                                    width: 90,
                                    height: 90,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.red.withOpacity(0.3),
                                        size: 28,
                                      ),
                                    ));
                              },
                              height: 90,
                            )
                          : Image.asset(
                              "assets/app_icon.jpg",
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
            ListTile(
              minLeadingWidth: 1,
              dense: true,
              leading: const Icon(Icons.person),
              title: setMediumLabel('Profile'),
              onTap: () {
                // Get.toNamed(AppRoutes.profile);
                Get.toNamed(AppPages.PROFILE);
                kDrawerKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              minLeadingWidth: 1,
              dense: true,
              leading: const Icon(Icons.calendar_month),
              title: setMediumLabel('Bookings'),
              onTap: () {
                // Get.toNamed(AppPages.);
              },
            ),
            ListTile(
              minLeadingWidth: 1,
              dense: true,
              leading: const Icon(Icons.live_tv_outlined),
              title: setMediumLabel('Library'),
              onTap: () async {
                await Get.toNamed(AppPages.PINNED);
                // Get.delete<PinnedController>();
              },
            ),
            ListTile(
              minLeadingWidth: 1,
              dense: true,
              leading: const Icon(Icons.school),
              title: setMediumLabel('Book Academy'),
              onTap: () async {
                // Get.toNamed(AppRoutes.academyList);
              },
            ),
            ListTile(
              minLeadingWidth: 1,
              dense: true,
              leading: const Icon(Icons.schedule),
              title: setMediumLabel('Book Slot'),
              onTap: () async {
                // Get.toNamed(AppRoutes.venueList);
              },
            ),
            ListTile(
              minLeadingWidth: 1,
              dense: true,
              leading: const Icon(Icons.vrpano),
              title: setMediumLabel('Book Experience'),
              onTap: () async {
                // Get.toNamed(AppPages.);
              },
            ),
            const Divider(),
            c.btnLoader!.value
                ? const ListTile(
                    minLeadingWidth: 1,
                    dense: true,
                    //height: 50,
                    leading: Icon(Icons.exit_to_app),
                    title: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ))
                : ListTile(
                    dense: true,
                    minLeadingWidth: 1,
                    title: setMediumLabel('Logout'),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () async {
                      // c.showLoader();
                      await c.logout();
                      // c.hideLoader();
                    },
                  ),
            getVerticalSpace(),
            ExpansionTile(
              title: setMediumLabel("Settings & Support", color: Colors.red),
              initiallyExpanded: true,
              children: [
                ListTile(
                  minLeadingWidth: 1,
                  dense: true,
                  leading: Icon(Icons.support_agent_sharp),
                  title: setMediumLabel('Contact Us'),
                  onTap: () {
                    launchUrlString("https://tidasports.com/contact-us/",
                        mode: LaunchMode.externalApplication);
                  },
                ),
                const Divider(),
                ListTile(
                  minLeadingWidth: 1,
                  dense: true,
                  leading: Icon(Icons.phone_forwarded),
                  title: setMediumLabel('Call Us'),
                  onTap: () {
                    makePhoneCall("+918195944444");
                  },
                ),
                const Divider(),
                ListTile(
                  minLeadingWidth: 1,
                  dense: true,
                  leading: const Icon(Icons.settings),
                  title: setMediumLabel('Settings'),
                  onTap: () => Get.toNamed(AppPages.SETTINGS),
                ),
              ],
            ),
            Image.asset(
              "assets/app_icon.jpg",
              fit: BoxFit.fitHeight,
              width: 90,
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        launchurl(
                            Uri.parse('https://www.facebook.com/tidasports/'));
                      },
                      child: Image.asset(
                        "assets/icons/facebook.png",
                        height: 30,
                      )),
                  GestureDetector(
                      onTap: () {
                        launchurl(
                            Uri.parse('https://www.instagram.com/tidasports/'));
                      },
                      child: Image.asset(
                        "assets/icons/instagram.png",
                        height: 30,
                      )),
                  GestureDetector(
                      onTap: () {
                        launchurl(Uri.parse(
                            'https://www.linkedin.com/company/tidasports/'));
                      },
                      child: Image.asset(
                        "assets/icons/linkedIn.png",
                        height: 30,
                      )),
                  GestureDetector(
                      onTap: () {
                        launchurl(
                            Uri.parse('https://www.youtube.com/@tidasports'));
                      },
                      child: Image.asset(
                        "assets/icons/youtube.png",
                        height: 30,
                      )),
                ],
              ),
            ),
            
            // ListTile(
            //   horizontalTitleGap: 10,
            //   minLeadingWidth: 1,
            //       dense: true,
            //       leading: Image.asset("assets/icons/facebook.png", height: 30,),
            //       title: setMediumLabel('Facebook'),
            //       onTap: () {
            //         launchurl(Uri.parse('https://www.facebook.com/tidasports/'));
            //       },
            // ),
            // ListTile(
            //   horizontalTitleGap: 10,
            //   minLeadingWidth: 1,
            //       dense: true,
            //       leading: Image.asset("assets/icons/instagram.png",height: 30),
            //       title: setMediumLabel('Instagram'),
            //       onTap: () {
            //         launchurl(Uri.parse('https://www.instagram.com/tidasports/'));
            //       },
            // ),
            // ListTile(
            //   horizontalTitleGap: 10,
            //   minLeadingWidth: 1,
            //       dense: true,
            //       leading: Image.asset("assets/icons/linkedIn.png",height: 30),
            //       title: setMediumLabel('LinkedIn'),
            //       onTap: () {
            //         launchurl(Uri.parse('https://www.linkedin.com/company/tidasports/'));
            //       },
            // ),
            // ListTile(
            //   horizontalTitleGap: 10,
            //   minLeadingWidth: 1,
            //       dense: true,
            //       leading: Image.asset("assets/icons/youtube.png",height: 30),
            //       title: setMediumLabel('YouTube'),
            //       onTap: () {
            //         launchurl(Uri.parse('https://www.youtube.com/@tidasports'));
            //       },
            // )
          ],
        ),
      );
    });
  }

  Future launchurl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
