// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/notification_model.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tida_customer/firebase_options.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print("Handling a background message: ${message.messageId}");
}
int totalnotifications = 0;
  late final FirebaseMessaging _messaging;
  PushNotificationModel? _notificationInfo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform
   );
   requestAndRegisterNotification();

  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  await MySharedPref.init();

  initializeDateFormatting().then((_) => runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "Tida Sports",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          transitionDuration: const Duration(milliseconds: 300),
          defaultTransition: Transition.rightToLeftWithFade,
          builder: (context, widget) {
            return Theme(
              data: getAppTheme(),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
            );
          },
          initialRoute:
              AppPages.INITIAL, // first screen to show when app is running
          getPages: AppPages.routes, // app screens
        );
      })));
}
 
  void requestAndRegisterNotification() async {
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    ;
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      print(token);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotificationModel pushNotificationModel = PushNotificationModel(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        _notificationInfo = pushNotificationModel;
        totalnotifications++;
      });
      if (_notificationInfo != null) {
        Get.toNamed(AppPages.ORDERS);
      }
    }
  }


