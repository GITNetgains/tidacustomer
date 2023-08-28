// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_interface.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/data/remote/endpoints.dart';
import 'package:tida_customer/app/modules/Home/controllers/home_controller.dart';
import 'package:tida_customer/app/modules/Home/models/logout_model.dart';
import 'package:tida_customer/app/modules/profile/models/my_profile_response.dart';
import 'package:tida_customer/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final homecontroller = Get.put(HomeController());
  String? userName, userImage, userEmail, userPhone, userId, token;
  bool? isEditing = false;
  XFile? selectedAvatar;
  File? croppedFile;
  String? userPropic;
  bool? isEnabled = false;

  bool? isUploading = false;
  bool? isLoading = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emCtrl = TextEditingController();
  TextEditingController phCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  bool btnLoader = false;

  void showLoader() {
    debugPrint("ShowLoader");
    btnLoader = true;
    update();
  }

  void hideLoader() {
    debugPrint("hideLoader");
    btnLoader = false;
    update();
  }

  bool btnLoader1 = false;

  void showLoader1() {
    debugPrint("ShowLoader");
    btnLoader1 = true;
    update();
  }

  void hideLoader1() {
    debugPrint("hideLoader");
    btnLoader1 = false;
    update();
  }

  Future<void> init() async {
    userName = MySharedPref.getName();
    userEmail = MySharedPref.getemail();
    userPhone = MySharedPref.getphone();
    userId = MySharedPref.getid();
    userImage = MySharedPref.getavatar();
    token = MySharedPref.getauthtoken();
    nameCtrl.text = isProperString(userName)! ? userName! : "";
    emCtrl.text = isProperString(userEmail)! ? userEmail! : "";
    phCtrl.text = isProperString(userPhone)! ? userPhone! : "";
    update();
  }

  bool? isProperString(String? s) {
    if (s != null && s.trim().isNotEmpty && s.trim() != "null") {
      return true;
    } else {
      return false;
    }
  }

  void pickImage(ImageSource source) async {
    selectedAvatar = await ImagePicker().pickImage(source: source);
    if (selectedAvatar != null) {
      CroppedFile? cf = await ImageCropper().cropImage(
        sourcePath: selectedAvatar!.path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );
      if (cf != null) {
        croppedFile = File(cf.path);
      }
    }

    update();
  }

  addPropicApi2() async {
    var headers = {
      'Content-Type': 'multipart/form-data;',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiInterface.baseUrl}/Userapi/updateProfile'));
    request.fields.addAll({
      'userid': userId!,
      'token': token!,
      'name': nameCtrl.text.trim(),
      'phone': phCtrl.text.trim(),
    });
    if (croppedFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', croppedFile!.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String? res = await response.stream.bytesToString();
      ProfileResponse? resp = null;
      if (response.statusCode == 200) {
        debugPrint("IMAGE SUCCESS $res");
        //ApiService().returnResponse(response.data);
        resp = profileResponseFromJson(res);
        //userPropic = res!.data!.s3FileName!.toString();

        MySharedPref.setid(resp!.data!.id.toString());
        MySharedPref.setName(resp.data!.name.toString());
        MySharedPref.setauthtoken(resp.data!.token.toString());
        MySharedPref.setemail(resp.data!.email.toString());
        MySharedPref.setphone(resp.data!.phone.toString());
        MySharedPref.setavatar(resp.data!.image.toString());
        isEditing = false;
        isEnabled = true;
        init();
        // await notificationApi();
        isUploading = false;
        //isNotUploading = true;
        homecontroller.updateImageVariable();
      } else {
        isUploading = false;
        Get.snackbar("Image Upload Failed Response Code ${response.statusCode}",
            "Error");
      }
      update();
    } else {
      print(response.reasonPhrase);
      isUploading = false;
      Get.snackbar("Image Upload Failed Response Code ${response.reasonPhrase}",
          "Error");
      update();
    }
  }

  addPropicApi() async {
    isUploading = true;
    update();
    debugPrint("MAKING IMAGE REQUEST");
    // String? userId = await SecuredStorage.readStringValue(Keys.userId);
    //var auth = await SharedPref.getString(SharedPref.authToken);
    try {
      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl =
          ApiInterface.baseUrl + Endpoints.userApiUpdateProfile;

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        //"Authorization": "Bearer " + auth!,
        //'Content-Type': 'application/x-www-form-urlencoded'
        // 'Content-Type': 'multipart/form-data',
        //'enctype': 'multipart/form-data'
        'Cookie':
            '__88ok4w0s48kwosg08404k0sswsowwg08ccc0c0s0=651fb6f5a64f8009c94b84cf4bc56535b42a677f; language=english'
      };

      //[3] ADDING EXTRA INFO
      var formData = dio.FormData.fromMap({
        'userid': userId,
        'token': token,
        'name': nameCtrl.text.trim(),
        'phone': phCtrl.text.trim(),
      });

      //[4] ADD IMAGE TO UPLOAD
      if (croppedFile != null) {
        var file = await dio.MultipartFile.fromFile(croppedFile!.path,
            filename: "profile_pic_${DateTime.now().toIso8601String()}",
            contentType: MediaType(
              "image",
              "profile_pic_${DateTime.now().toIso8601String()}",
            ));

        formData.files.add(MapEntry('image', file));
      }

      //[5] SEND TO SERVER
      if (croppedFile != null) {
        var response = await dioRequest.post(
          ApiInterface.baseUrl + Endpoints.userApiUpdateProfile,
          data: formData,
        );
        ProfileResponse? resp = null;
        if (response.statusCode == 200) {
          debugPrint("IMAGE SUCCESS ${response.data}");
          //ApiService().returnResponse(response.data);
          resp = ProfileResponse.fromJson(response.data);
          //userPropic = res!.data!.s3FileName!.toString();

          MySharedPref.setid(resp.data!.id.toString());
          MySharedPref.setName(resp.data!.name.toString());
          MySharedPref.setauthtoken(resp.data!.token.toString());
          MySharedPref.setemail(resp.data!.email.toString());
          MySharedPref.setphone(resp.data!.phone.toString());
          MySharedPref.setavatar(resp.data!.image.toString());
          isEditing = false;
          isEnabled = true;

          // await notificationApi();
          isUploading = false;
          //isNotUploading = true;
        } else {
          isUploading = false;
          Get.snackbar(
              "Image Upload Failed Response Code ${response.statusCode}",
              "Error");
        }
        update();
        //Navigator.of(context).pop();
      } else {
        //Navigator.of(context).pop();
        // isNotUploading = true;
        isUploading = false;
        update();
      }
    } on dio.DioError catch (err) {
      debugPrint("EROR111 ${err.message}");
      isUploading = false;
      Get.snackbar(err.message ?? "", "Error");
      if (err.response == null) {
        debugPrint("Error 1");
        //isNotUploading = true;
      }
      if (err.response != null && err.response!.statusCode == 413) {
        debugPrint("Error 413");
        //isNotUploading = true;
        //update();
      }
      if (err.response != null && err.response!.statusCode == 400) {
        debugPrint("Error 400");
        //isNotUploading = true;
        //update();
      }
      update();
    }
  }

  Future<void> logout() async {
    var data = {
      "userid": userId.toString(), //"3",
      "token": token //"dfdd92bea16946f54b1cfe794dca3db9",
    };

    await ApiService.logout(data).then((response) async {
      LogoutResponseModel? res = logoutResponseModelFromJson(response);
      debugPrint("IN hEEre1");
      if (res.status!) {
        debugPrint("IN hEEre");
         MySharedPref.clearSession();
        Get.offAllNamed(AppPages.LOGIN);
        update();
      } else {
        debugPrint("IN hEEre3");
        Get.snackbar("Error", "${res.message}");
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
    });
  }

  Future<void> deleteProfile() async {
    isLoading = true;
    update();
    var data = {
      "userid": userId.toString(), //"3",
      "token": token,
      "type": "1"
    };
    await ApiService.deleteProfile(data).then((response) async {
      LogoutResponseModel? res = logoutResponseModelFromJson(response);
      debugPrint("IN hEEre1");
      if (res.status!) {
        debugPrint("IN hEEre");
        isLoading = false;
        update();
         MySharedPref.clearSession();
        Get.offAllNamed(AppPages.LOGIN);
        update();
      } else {
        debugPrint("IN hEEre3");
        Get.snackbar("Error", "${res.message}");
        isLoading = false;
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
      isLoading = false;
    });
  }
}
