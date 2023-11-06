import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/models/notification_model.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tida_customer/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await setupFlutterNotifications();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

int totalnotifications = 0;
late final FirebaseMessaging _messaging;
PushNotificationModel? _notificationInfo;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  // Push Notifications Configuration
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  requestAndRegisterNotification();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // final http.Response response =
      //     await http.get(Uri.parse(android.imageUrl ?? ""));
      // BigPictureStyleInformation bigPictureStyleInformation =
      //     BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
      //         base64Encode(response.bodyBytes)));
      // final ByteData data = await rootBundle.load('assets/app_icon.jpg');
      // final List<int> bytes = data.buffer.asByteData();
      // File _imageFile = File('assets/app_icon.jpg');

      // // Read bytes from the file object
      // Uint8List _bytes = await _imageFile.readAsBytes();

      // // base64 encode the bytes
      // String _base64String = base64.encode(_bytes);

      // Create the BigPictureStyleInformation
      // final BigPictureStyleInformation bigPictureStyleInformation =
      //     BigPictureStyleInformation(
      //         ByteArrayAndroidBitmap.fromBase64String(_base64String));

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                icon: "@mipmap/ic_launcher",
                importance: Importance.high,
                priority: Priority.high,
                // styleInformation: bigPictureStyleInformation,
              ),
              iOS: const DarwinNotificationDetails()),
          payload: android.imageUrl);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // showDialog(
      //   context: context,
      //   builder: (_) {
      //     return AlertDialog(
      //       title: Text(notification.title ?? ""),
      //       content: SingleChildScrollView(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [Text(notification.body ?? "")],
      //         ),
      //       ),
      //     );
      //   },
      // );
    }
  });

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

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
    Get.toNamed(
      AppPages.ORDERS,
    );
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> requestAndRegisterNotification() async {
  // const initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // const DarwinInitializationSettings initializationSettingsDarwin =
  //     DarwinInitializationSettings();
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initializationSettingsDarwin,
  // );
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   if (notification != null && android != null) {
  //     final http.Response response =
  //         await http.get(Uri.parse(android.imageUrl ?? ""));
  //     BigPictureStyleInformation bigPictureStyleInformation =
  //         BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
  //             base64Encode(response.bodyBytes)));

  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(channel.id, channel.name,
  //                 channelDescription: channel.description,
  //                 color: Colors.blue,
  //                 icon: "@mipmap/ic_launcher",
  //                 importance: Importance.high,
  //                 priority: Priority.high,
  //                 styleInformation: bigPictureStyleInformation),
  //             iOS: const DarwinNotificationDetails()),
  //         payload: android.imageUrl);
  //   }
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   // if (notification != null && android != null) {
  //   //   showDialog(
  //   //       // context: context,
  //   //       builder: (_) {
  //   //         return AlertDialog(
  //   //           title: Text(notification.title ?? ""),
  //   //           content: SingleChildScrollView(
  //   //             child: Column(
  //   //               crossAxisAlignment: CrossAxisAlignment.start,
  //   //               children: [Text(notification.body ?? "")],
  //   //             ),
  //   //           ),
  //   //         );
  //   //       },
  //   //       context: context);
  //   // }
  // });
}
