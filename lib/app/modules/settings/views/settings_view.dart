import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/settings/controllers/settings_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (c) {
      return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("Settings", color: Colors.white),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.ABOUT_US);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: setMediumLabel("About"),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.ABOUT_US);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: setMediumLabel("Frequently Asked Questions"),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.ABOUT_US);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: setMediumLabel("Terms & Conditions"),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.ABOUT_US);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: setMediumLabel("Privacy Policy"),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            c.launchurl(Uri.parse(
                                'https://www.facebook.com/tidasports/'));
                          },
                          child: Image.asset(
                            "assets/icons/facebook.png",
                            height: 30,
                          )),
                      GestureDetector(
                          onTap: () {
                            c.launchurl(Uri.parse(
                                'https://www.instagram.com/tidasports/'));
                          },
                          child: Image.asset(
                            "assets/icons/instagram.png",
                            height: 30,
                          )),
                      GestureDetector(
                          onTap: () {
                            c.launchurl(Uri.parse(
                                'https://www.linkedin.com/company/tidasports/'));
                          },
                          child: Image.asset(
                            "assets/icons/linkedIn.png",
                            height: 30,
                          )),
                      GestureDetector(
                          onTap: () {
                            c.launchurl(Uri.parse(
                                'https://www.youtube.com/@tidasports'));
                          },
                          child: Image.asset(
                            "assets/icons/youtube.png",
                            height: 30,
                          )),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: setSmallLabel("Version 1.0.1"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
