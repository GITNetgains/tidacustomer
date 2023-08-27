import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

void openMap(lat, lon) {
  // if (isProperString(lat)! &&
  //     isProperString(lon)! &&
  //     double.tryParse(lat) != null &&
  //     double.tryParse(lon) != null) {
  //   if (Platform.isAndroid) {
  //     navigateTo(double.parse(lat), double.parse(lon));
  //   } else {
  //     launchMaps(double.parse(lat), double.parse(lon));
  //   }
  // } else {
  //   debugPrint("Cant launch..");
  //   Get.snackbar("Can't launch map", "Insufficient/invalid coordinates.",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 5));
  // }
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


Widget basebody(bool isLoading, Widget widget)
{
  return AbsorbPointer(
    absorbing: isLoading,
    child:  isLoading ?  Center(child: Image.asset("assets/animation/loading_anim.gif")) : widget/*Stack(
      children: [widget],
    )*/,
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