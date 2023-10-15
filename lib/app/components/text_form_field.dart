import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tida_customer/config/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hinttext;
  final bool? obscureText;
  final List<TextInputFormatter>? textinputformatters;
  final TextInputType? keyboardType;
  const CustomTextFormField({super.key, required this.textEditingController, this.hinttext, this.obscureText, this.textinputformatters, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                      borderRadius:  BorderRadius.all(Radius.circular(10.r)),
                      color: Colors.grey.withOpacity(0.2)),
      child: TextField(
        style: TextStyle(fontSize: MEDIUM_FONT.sp),
        keyboardType: keyboardType,
        inputFormatters:textinputformatters,
        obscureText: obscureText ?? false,
        controller: textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: LARGE_PADDING.sp),
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey, fontSize: MEDIUM_FONT.sp)),
      ),
    );
  }
}
