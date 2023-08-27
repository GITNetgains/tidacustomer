import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(hours: 2));
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
