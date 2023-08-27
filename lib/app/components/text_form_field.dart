import 'package:flutter/material.dart';
import 'package:tida_customer/config/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hinttext;
  final bool? obscureText;
  const CustomTextFormField({super.key, required this.textEditingController, this.hinttext, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.withOpacity(0.2)),
      child: TextField(
        obscureText: obscureText ?? false,
        controller: textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: LARGE_PADDING),
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
