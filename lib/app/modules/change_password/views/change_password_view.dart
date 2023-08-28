import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/modules/change_password/controllers/change_password_vm.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: PRIMARY_COLOR,
            title: Text("Change Password"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: NORMAL_PADDING),
                      child: Image.asset(
                        "assets/padlock.png",
                        width: 18,
                        height: 18,
                      ),
                    ),
                    setMediumLabel("New Password"),
                  ],
                ),
                getVerticalSpace(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.withOpacity(0.2)),
                  child: TextField(
                    controller: c.newpassword,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                        hintText: "**********",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                getVerticalSpace(),
                getVerticalSpace(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: NORMAL_PADDING),
                      child: Image.asset(
                        "assets/padlock.png",
                        width: 18,
                        height: 18,
                      ),
                    ),
                    setMediumLabel("Confirm New Password"),
                  ],
                ),
                getVerticalSpace(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.withOpacity(0.2)),
                  child: TextField(
                    controller: c.confirmpassword,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                        hintText: "**********",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                getVerticalSpace(),
                getVerticalSpace(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: getSecondaryButton("Save", () async {
                      // c.showLoader();
                      c.changepass();
                      // // await c.logout();
                      // Get.toNamed(AppRoutes.changepassword);
                      // c.hideLoader();
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
