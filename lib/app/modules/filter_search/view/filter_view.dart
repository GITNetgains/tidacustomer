import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/modules/filter_search/controller/filter_search_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';

class FilterSearchView extends StatelessWidget {
  const FilterSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterSearchController>(builder: (c) {
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: {"update": true});
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: setHeadlineMedium("Search Filters", color: Colors.white),
          ),
          body: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Select Location',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: c!.showLocLoader!
                    ? setSmallLabel("Loading...")
                    : setSmallLabel(c.homeCtrl.city.value!),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.black),
                onTap: () {
                  handlePressButton(c, context);
                },
              ),
              const Divider(),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Radius',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      Text(
                        '${ c.searchScreenCtrl.radius} KM',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    setXSmallLabel("10 KM"),
                    SizedBox(
                        width: 360.w * 0.7,
                        child: Slider(
                          value: c.initialVal,
                          onChanged: (value) async {
                            c.initialVal = value;
                            c.searchScreenCtrl.radius = value.toString();
                            c.searchScreenCtrl.update();
                             MySharedPref.setfilterradius(
                                 value.toString());
                            
                            c.update();
                          },
                          min: 10,
                          max: 100,
                          activeColor: Colors.red,
                          divisions: 10,
                        )),
                    setSmallLabel("100+ KM"),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Select Type',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: ChipsChoice<String>.multiple(
                  wrapped: true,
                  value: c.tags,
                  choiceCheckmark: true,
                  onChanged: (List<String> val) async {
                    debugPrint("Choice chips on changed $val");
                    c.tags.clear();
                    for (var i = 0; i < val.length; i++) {
                      c.tags.add(val[i]);
                    }
                    String? typeFilter = "";
                    for (var i = 0; i < c.tags.length; i++) {
                      typeFilter = typeFilter! +
                          c.tags[i] +
                          (i == c.tags.length - 1 ? "" : ",");
                    }
                    c.searchScreenCtrl.tags = typeFilter;
                    c.searchScreenCtrl.update();
                     MySharedPref.setfiltervenue(
                        typeFilter!);
                    c.update();
                  },
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: c.options,
                    value: (i, v) => v,
                    label: (i, v) => v,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      );
    });
  }

  Future<void> handlePressButton(FilterSearchController c, context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: c.kGoogleApiKey!,
      onError: (PlacesAutocompleteResponse res) {
        debugPrint("Places error ${res.errorMessage}");
      },
      types: [""],
      mode: Mode.overlay,
      strictbounds: false,
      language: "En",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "in")],
    );
    if (p != null) {
      displayPrediction(c, p);
    } else {
      c.showLocLoader = false;
      c.update();
    }
  }

  Future<Null> displayPrediction(FilterSearchController c, Prediction p) async {
    try {
      if (p != null) {
        // get detail (lat/lng)
        c.showLocLoader = true;
        c.update();
        GoogleMapsPlaces places = GoogleMapsPlaces(
          apiKey: c.kGoogleApiKey!,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        MySharedPref.setlati( lat.toString());
        MySharedPref.setlongi( lng.toString());
        List<geo.Placemark> placemarks =
            await geo.placemarkFromCoordinates(lat, lng);

        geo.Placemark placemark = placemarks[0];
        debugPrint("placemark ${placemark.locality}");
        //city = placemark.locality;
        MySharedPref.setcity( placemark.locality!);

        c.homeCtrl.city.value = placemark.locality!;
        c.homeCtrl.lati = lat.toString();
        c.homeCtrl.longi = lng.toString();
        c.homeCtrl.currPos = Position(
            longitude: lng,
            latitude: lat,
            timestamp: null,
            accuracy: 0.0,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0);
        await c.homeCtrl.init();
        // c.homeCtrl.getData();
        // c.homeCtrl.getSportsData();
        c.homeCtrl.update();
        c.showLocLoader = false;
        c.update();

        //Get.snackbar(
        //"Result",
        //"${p.description} - $lat/$lng, ${p.placeId}",
        //);
      } else {
        c.showLocLoader = false;
        c.update();
        debugPrint("display predictions else ");
      }
    } on Exception catch (e) {
      c.showLocLoader = false;
      c.update();
      Get.snackbar("Unable to update location", e.toString());
    }
  }
}