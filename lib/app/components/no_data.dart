import 'package:flutter/material.dart';
import 'package:tida_customer/config/theme/app_theme.dart';

class NoData extends StatelessWidget {
  String? msg;

  NoData({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
            child: setSmallLabel(msg ?? "No Data Available",
                align: TextAlign.center)));
  }
}