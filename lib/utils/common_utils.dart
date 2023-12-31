import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
}

void openMap(lat, lon, place) {
  String title = "";
  if (isProperString(lat)! &&
      isProperString(lon)! &&
      double.tryParse(lat) != null &&
      double.tryParse(lon) != null) {
    if (Platform.isAndroid) {
      navigateTo(double.parse(lat), double.parse(lon), place ?? title);
    } else {
      navigateTo(double.parse(lat), double.parse(lon), place ?? title);
    }
  } else {
    debugPrint("Cant launch..");
    Get.snackbar("Can't launch map", "Insufficient/invalid coordinates.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5));
  }
}

void navigateTo(double lat, double lng, String title) async {
  try {
    print("------------");

    final availableMaps = await MapLauncher.installedMaps;
    print(
        availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    if (Platform.isIOS) {
      await MapLauncher.showDirections(
        mapType: MapType.apple,
        destination: Coords(lat, lng),
        destinationTitle: title,
      );
    } else {
      await MapLauncher.showDirections(
        destinationTitle: title,
        mapType: MapType.google,
        destination: Coords(lat, lng),
      );
    }
  } catch (e) {
    throw e;
  }
}

launchMaps(lat, lon) async {
  String googleUrl = 'comgooglemaps://?center=$lat,$lon';
  String appleUrl = 'https://maps.apple.com/?sll=$lat,$lon';
  if (await canLaunchUrlString("comgooglemaps://")) {
    debugPrint('launching com googleUrl');
    await launchUrlString(googleUrl);
  } else if (await canLaunchUrlString(appleUrl)) {
    debugPrint('launching apple url');
    await launchUrlString(appleUrl);
  } else {
    throw 'Could not launch url';
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(value)) ? false : true;
}

Future<void> makePhoneCall(String phoneNumber) async {
  try {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  } on Exception catch (e) {
    Get.snackbar("Can't open dialpad", "Invalid contact No. $phoneNumber",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5));
  }
}

bool? isPasswordCompliant(String password, [int minLength = 8]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length >= minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

Widget basebody(bool isLoading, Widget widget) {
  return AbsorbPointer(
    absorbing: isLoading,
    child: isLoading
        ? Center(child: Image.asset(AppImages.overallloading))
        : widget /*Stack(
      children: [widget],
    )*/
    ,
  );
}

bool? isProperString(String? s) {
  if (s != null &&
      s.toString().trim().isNotEmpty &&
      s.toString().trim() != "null") {
    return true;
  }
  return false;
}

Widget getFooter(String lat, String lng, String place) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        width: MediaQuery.of(Get.context!).size.width * 0.44,
        child: InkWell(
          onTap: () {
            makePhoneCall("+918195944444");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.call,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: setSmallLabel("Call Us"),
              ),
            ],
          ),
        ),
      ),
      getHorizontalSpace(),
      InkWell(
        onTap: () {
          openMap(lat, lng, place);
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          width: MediaQuery.of(Get.context!).size.width * 0.44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.directions,
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: setSmallLabel("View on map"),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
