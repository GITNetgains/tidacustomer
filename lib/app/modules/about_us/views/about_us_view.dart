import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/about_us/controllers/about_us_controller.dart';
import 'package:tida_customer/app/modules/settings/controllers/settings_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tida_customer/utils/color_utils.dart';

class AboutUsView extends StatelessWidget {

  const AboutUsView({super.key,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
             backgroundColor: PRIMARY_COLOR,
              title: setHeadlineMedium(c.appbartext.value, color: Colors.white),
          ),
          body: ListView(
            children: [
              HtmlWidget(
                 //r""" """,
                c.inputtext.value
            )
            ],
          ),
        );
      }
    );
  }
}