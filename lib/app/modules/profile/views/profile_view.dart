import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_customer/app/modules/profile/controllers/profile_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("My Profile", color: Colors.white),
          actions: [
            c.isEditing!
                ? Container()
                : InkWell(
                    onTap: () {
                      c.isEditing = !c.isEditing!;
                      c.update();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.edit, color: Colors.white,),
                    ),
                  )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.deepOrange.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: !c.isEditing!
                            ? null
                            : () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoActionSheet(
                                          // title: const Text('Choose Options'),
                                          // message: const Text('Your options are '),
                                          actions: <Widget>[
                                        CupertinoActionSheetAction(
                                          child: const Text(
                                            "Select photo",
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                                context, "Select photo");
                                            c.pickImage(ImageSource.gallery);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: const Text(
                                            "Take photo",
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                                context, "Take photo");
                                            c.pickImage(ImageSource.camera);
                                          },
                                        )
                                      ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            isDefaultAction: true,
                                            onPressed: () {
                                              Navigator.pop(context, "Cancel");
                                            },
                                            child: const Text(
                                              "Cancel",
                                            ),
                                          )),
                                );
                              },
                        child: Container(
                            width: 120,
                            height: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(60)),
                            //backgroundColor: Colors.white70,
                            //minRadius: 60.0,
                            child: Container(
                              width: 120,
                              height: 120,
                              //padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  //  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(60)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: c.croppedFile != null
                                      ? Image.file(
                                          File(c.croppedFile!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : c.isProperString(c.userImage)!
                                          ? getImagewidget(
                                              c.userImage.toString(),
                                            )
                                          : Container(
                                      color: Colors.red.withOpacity(0.1),
                                      width: 100,
                                      height: 100,
                                      child:   Center(child: Icon(Icons.image_not_supported_outlined, color:Colors.red.withOpacity(0.3),size: 48,),))),
                            )
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  c.isEditing!
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                          ),
                          child: TextField(
                            controller: c.nameCtrl,
                            decoration: const InputDecoration(
                                focusColor: Colors.white,
                                hintText: "Enter Name",
                                hintStyle: TextStyle(color: Colors.white)),
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                      : Text(
                          c.isProperString(c.userName)!
                              ? c.userName!
                              : 'Tida Sports',
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: c.isEditing!
                      ? TextField(
                          controller: c.emCtrl,
                          decoration: const InputDecoration(
                            hintText: "Enter email",
                          ),
                          readOnly: true,
                        )
                      : Text(
                          c.isProperString(c.userEmail)! ? c.userEmail! : 'N/A',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Phone',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: c.isEditing!
                      ? TextField(
                          controller: c.phCtrl,
                          decoration: const InputDecoration(
                            hintText: "Enter phone",
                          ),
                        )
                      : Text(
                          c.isProperString(c.userPhone)!
                              ? c.userPhone!
                              : "N/A" /*'+91987654321'*/,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
                const Divider(),
                // const ListTile(
                //   title: Text(
                //     'Transaction History',
                //     style: TextStyle(
                //       color: Colors.deepOrange,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   trailing: Icon(Icons.arrow_forward_ios_rounded,
                //       color: Colors.black),
                // ),
                // const Divider(),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  c.isEditing==true?  SizedBox(
                    width: double.infinity,
                    child: c.btnLoader
                        ? Container(
                        height: 50,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ))
                        : c.btnLoader1
                        ? Container(
                      //height: 50,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        )):getSecondaryButton("Save", () async {
                      c.showLoader1();
                      await c.addPropicApi2();
                      c.hideLoader1();
                    }),
                  ):  SizedBox(
                    width: double.infinity,
                    child: c.btnLoader
                        ? Container(
                            height: 50,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            ))
                        : getSecondaryButton("Logout", () async {
                            c.showLoader();
                            await c.logout();
                            c.hideLoader();
                          }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   c.isEditing==true?  Container():  SizedBox(
                    width: double.infinity,
                    child: c.btnLoader
                        ? Container(
                            height: 50,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            ))
                        : getSecondaryButton("Edit Password", () async {
                            c.showLoader();
                            // await c.logout();
                            Get.toNamed(AppPages.CHANGE_PASSWORD);
                            c.hideLoader();
                          }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  c.isLoading==true?Center(child: CircularProgressIndicator(color: Colors.red,),):
                  setTextButton("Delete Account", callback: () {
                    Get.dialog(Center(
                      child: Wrap(
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 35, vertical: 24),
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: setPrimaryTextMed("Once the delete request is initiated, you would be no longer to access your account. Your data will be removed from servers in 14 days from the date of deletion request"))
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      getPrimaryButton("Delete", () {
                                        c.deleteProfile();
                                      }) ,getPrimaryButton("Back", () {
                                        Get.back();
                                      })

                                    ],

                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
                  })

                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
