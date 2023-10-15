import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';

class CustomButton extends StatelessWidget {
  final String btntxt;
  final Function()? onTap;
  const CustomButton({super.key, required this.btntxt, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:16.0).h,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0.r),),
          color: PRIMARY_COLOR,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0).h,
              child: setTextButton(btntxt, color: SECENDARY_COLOR)
            ),
          ),
        ),
      ),
    );
  }
}