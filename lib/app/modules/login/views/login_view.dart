import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tida_customer/app/components/app_bottom_sheet.dart';
import 'package:tida_customer/app/components/custom_button.dart';
import 'package:tida_customer/app/components/text_field.dart';
import 'package:tida_customer/app/components/text_form_field.dart';
import 'package:tida_customer/app/modules/login/controllers/login_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/main.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/constants.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (c) {
      return Scaffold(
        bottomSheet: const AppBottomSheet(),
        body: Padding(
          padding: const EdgeInsets.all(16.0).h,
          child: basebody(
            c.isLoading.value,
            ListView(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  AppImages.kappicon,
                  height: 200.h,
                  width: 200.w,
                ),
                Center(
                    child: setSmallLabel(
                        "TRANSFORMING INDIA'S DEVELOPING ATHLETES",
                        align: TextAlign.center)),
                getVerticalSpace(),
                CustomListTile(
                  tiletext: "User",
                  iconData: AppImages.kuser,
                ),
                CustomTextFormField(
                  textEditingController: c.emailcontroller,
                  hinttext: "Customer@gmail.com",
                ),
                getVerticalSpace(),
                CustomListTile(
                  tiletext: "Password",
                  iconData: AppImages.kpassword,
                ),
                CustomTextFormField(
                  textEditingController: c.passwordcontroller,
                  hinttext: "**********",
                  obscureText: true,
                ),
                getVerticalSpace(),
                getVerticalSpace(),
                CustomButton(
                  btntxt: "LOGIN",
                  onTap: () {
                    c.login();
                  },
                ),
                getVerticalSpace(),
                InkWell(
                    onTap: () {
                      c.forgotpassworddialog();
                    },
                    child: Center(child: setMediumLabel("Forgot Password?"))),
                getVerticalSpace(),
                getVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setMediumLabel("Don't have an account?"),
                    getHorizontalSpace(),
                    InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.REGISTER);
                        },
                        child: setMediumLabel("REGISTER",
                            color: Colors.red,
                            decoration: TextDecoration.underline)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).h,
                  child: Center(
                    child: InkWell(
                        onTap: () {
                          c.guestlogin();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            setMediumLabel(
                              "Login as ",
                            ),
                            setMediumLabel("Guest user", color: Colors.red),
                          ],
                        )),
                  ),
                ),
                getVerticalSpace(),
                getVerticalSpace(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
