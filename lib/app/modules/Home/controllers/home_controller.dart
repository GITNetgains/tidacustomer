import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:tida_customer/app/data/models/nearby_search_response.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/Home/models/logout_model.dart';
import 'package:tida_customer/app/modules/sports/models/sports_data_response.dart';
import 'package:tida_customer/app/routes/app_pages.dart';

class HomeController extends GetxController {
  String? name;
  String? authtoken;
  String? email;
  Position? currPos;
  String? avatar;
  String? id;
  String? lati;
  String? longi;
  RxBool btnLoader = false.obs;
  RxString city = "Chandigarh".obs;
  RxBool showLocLoader = false.obs;
  RxBool isLoading = false.obs;
  RxBool showData = false.obs;
  TextEditingController fillgoogleplaces = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey(); // Create a key
  List<Datum?>? sportslist = List.empty(growable: true);
  List<Academy?>? academies = List.empty(growable: true);
  List<Tournament?>? tournamentslist = List.empty(growable: true);
  List<Venue?>? venueshomelist = List.empty(growable: true);
  List<Experience?>? experienceslist = List.empty(growable: true);
  RxString? kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0".obs;
  RxBool getloc = true.obs;
  RxString radius = "10".obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> handlePressButton(context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      hint: "Search location",
      apiKey: kGoogleApiKey!.value,
      onError: (PlacesAutocompleteResponse res) {
        debugPrint("Places error ${res.errorMessage}");
      },
      types: [""],
      mode: Mode.overlay,
      strictbounds: false,
      language: "en",
      components: [Component(Component.country, "in")],
    );
    print("---------dsfsdf-sdf---------");
    if (p != null) {
      displayPrediction(p);
    } else {
      showLocLoader(false);
      update();
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    try {
      showLocLoader(true);
      update();
      if (p != null) {
        // get detail (lat/lng)
        GoogleMapsPlaces places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey!.value,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        MySharedPref.setlati(lat.toString());
        MySharedPref.setlongi(lng.toString());
        List<geo.Placemark> placemarks =
            await geo.placemarkFromCoordinates(lat, lng);

        geo.Placemark placemark = placemarks[0];
        debugPrint("placemark ${placemark.locality}");
        //city = placemark.locality;
        MySharedPref.setcity(placemark.locality!);

        city.value = placemark.locality!;
        lati = lat.toString();
        longi = lng.toString();
        currPos = Position(
            longitude: lng,
            latitude: lat,
            timestamp: null,
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0);
        showLocLoader(false);

        // await c.getData();
        // await c.getSportsData();
        getloc(false);
        update();
        init();

        update();
        //Get.snackbar(
        //"Result",
        //"${p.description} - $lat/$lng, ${p.placeId}",
        //);
      } else {
        showLocLoader(false);
        update();
        debugPrint("display predictions else ");
      }
    } on Exception catch (e) {
      showLocLoader(false);
      update();
      Get.snackbar("Unable to update location", e.toString());
    }
  }

  Future<void> init() async {
    name = MySharedPref.getName();
    id = MySharedPref.getid();
    authtoken = MySharedPref.getauthtoken();
    email = MySharedPref.getemail();
    avatar = MySharedPref.getavatar();
    clearList();
    sportsdata();
    if(getloc.value == true)
    {
    _determinePosition();
    }
    else
    {
      getData();
    }
  }

  void _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        Get.snackbar("Please enable your location", "Enable your location.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
        return; //Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          Get.snackbar("Location permissions are denied",
              "Location permissions are denied.",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          isLoading(false);
          update();
          return;
          // Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        Get.snackbar("Permissions are permanently denied",
            "Location permissions are permanently denied, we cannot request permissions.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
        return;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      debugPrint("Current Location ${await Geolocator.getCurrentPosition()}");
      getCurrentPosition();
      return;
    } on Exception catch (e) {
      Get.snackbar("Unable to get location", "Internal library error.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isLoading(false);
      showData(false);
      update();
    }
    //await Geolocator.getCurrentPosition();
  }

  void getCurrentPosition() async {
    try {
      currPos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(currPos);
      if (currPos != null) {
        lati = currPos!.latitude.toString();
        longi = currPos!.longitude.toString();
        MySharedPref.setlati(currPos!.latitude.toString());
        MySharedPref.setlongi(currPos!.longitude.toString());
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currPos!.latitude, currPos!.longitude);

        Placemark placemark = placemarks[0];
        debugPrint("placemark ${placemark.locality}");
        city(placemark.locality);
        MySharedPref.setcity(city.value);
        update();
        await getData();
        isLoading(false);
        showData(true);
        update();
      }
    } on Exception catch (e) {
      Get.snackbar("Unable to get location", "Internal library error.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isLoading(false);
      showData(false);
      update();
    }
  }

  Future<void> getData() async {
    var data = {
      "userid": MySharedPref.getid().toString(), //"3",
      "token": MySharedPref.getauthtoken()
          .toString(), //"818a6c40f90ceaf27584d9c5ae38f1a2",
      "latitude": lati.toString(),
      "longitude": longi.toString(),
      "distance_km": radius.value.toString()
    };

    debugPrint("nearby req data $data");
    await ApiService.getSearchNearByLoc(data).then((response) {
      NearbyDataResponse? res = nearbyDataResponseFromJson(response);
      if (res!.status!) {
        venueshomelist!.addAll(res.data!.venue!);
        academies!.addAll(res.data!.academy!);
        tournamentslist!.addAll(res.data!.tournament!);
        tournamentslist = tournamentslist!.reversed.toList();
        experienceslist!.addAll(res.data!.experience!);
        update();
      } else {
        debugPrint("IN hEEre3");
        if (res.message == "Session Expired. Please Login Again.") {
          Get.offAllNamed(AppPages.LOGIN);
          MySharedPref.clearSession();
        }
      }
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
    });
  }

  void clearList() {
    venueshomelist!.clear();
    academies!.clear();
    tournamentslist!.clear();
    experienceslist!.clear();
    sportslist!.clear();
  }

  void sportsdata() {
    SportsDataResponse? sportsDataResponse =
        sportsDataResponseFromJson(MySharedPref.getSportsData().toString());
    if (sportsDataResponse!.status!) {
      sportslist!.addAll(sportsDataResponse.data!);
    }
  }

  Future<void> logout() async {
    var data = {
      "userid": MySharedPref.getid(), //"3",
      "token": MySharedPref.getauthtoken() //"dfdd92bea16946f54b1cfe794dca3db9",
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
        MySharedPref.clearSession();
        Get.offAllNamed(AppPages.LOGIN);
      }
    }).onError((error, stackTrace) async {
      MySharedPref.clearSession();
      Get.offAllNamed(AppPages.LOGIN);
      update();
    });
  }
}
