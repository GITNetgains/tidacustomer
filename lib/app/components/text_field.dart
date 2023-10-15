import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tida_customer/config/theme/app_theme.dart';

class CustomListTile extends StatelessWidget {
  final String? iconData;
  final String tiletext;
  const CustomListTile({super.key, this.iconData, required this.tiletext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: LARGE_PADDING.h ,bottom: SMALL_PADDING.h),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: NORMAL_PADDING.w),
            child: Image.asset(
              iconData ?? "",
              width: 18.w,
              height: 18.h,
            ),
          ),
          setMediumLabel(tiletext),
        ],
      ),
    );
  }
}
