import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/app_bottom_sheet.dart';
import 'package:tida_customer/app/components/custom_button.dart';
import 'package:tida_customer/app/components/text_field.dart';
import 'package:tida_customer/app/components/text_form_field.dart';
import 'package:tida_customer/app/modules/register/controllers/register_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/constants.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Create a account"),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        bottomSheet: AppBottomSheet(),
        body: Padding(
          padding: const EdgeInsets.all(16.0).h,
          child: basebody(
            c.isLoading.value,
            ListView(
              children: [
                registerfield(
                    "Name", AppImages.kuser, "John Doe", c.namecontroller),
                registerfield("Email", AppImages.kuser, "johndoe@hotmail.com",
                    c.emailcontroller),
                registerfield(
                    "Phone", AppImages.kuser, "(Optional)", c.phonecontroller),
                registerfield(
                    "Password(Minimum of 8 characters)",
                    AppImages.kpassword,
                    "***********",
                    c.passwordcontroller,
                    true),
                registerfield("Confirm Password", AppImages.kpassword,
                    "***********", c.confirmpasswordcontroller, true),
                getVerticalSpace(),
                getVerticalSpace(),
                CustomButton(
                  btntxt: "REGISTER",
                  onTap: () {
                    c.signup();
                  },
                ),
                getVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setMediumLabel("Already Have an account?"),
                    getHorizontalSpace(),
                    InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.LOGIN);
                        },
                        child: setMediumLabel("LOGIN",
                            color: Colors.red,
                            decoration: TextDecoration.underline)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget registerfield(String lablefield, String imageasset, String hintfield,
      TextEditingController textEditingController,
      [bool obscureText = false]) {
    return Column(
      children: [
        getVerticalSpace(),
        CustomListTile(
          tiletext: lablefield,
          iconData: imageasset,
        ),
        CustomTextFormField(
          textEditingController: textEditingController,
          hinttext: hintfield,
          obscureText: obscureText,
        )
      ],
    );
  }
}
