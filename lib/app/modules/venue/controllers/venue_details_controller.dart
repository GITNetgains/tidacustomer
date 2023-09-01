import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/data/remote/api_service.dart';
import 'package:tida_customer/app/modules/venue/models/venue_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tida_customer/app/data/models/get_media_model.dart' as m;

class VenueFullDetailsController extends GetxController {
  String? userId, userName, token;
  List<Datum?>? venues = List.empty(growable: true);
  String? venueName = "", venueDescription = "", venueAdd = "", venueAvail = "";
  List<String>? amenities = List.empty(growable: true);
  List<SportsDetail?>? sports = List.empty(growable: true);
  List<String>? selectedSports = [];
  List<Facility?>? facilites = List.empty(growable: true);
  Map<String, List<Facility>> groupedFacilities = {};

  //List<RatingElement>? rating = List.empty(growable: true);
  double? actualRating = 0.0;
  RxString videoUrl = "".obs;
  String lat = "";
  String lng = "";
  bool? isLoading = true;
  RxBool isVideoPlaying = false.obs;

  List<String> images = [];
  List<String> tags = [];
  List<String> options = [
    'Wifi',
    'Entertainment',
    'Cafeteria',
    'Parking',
    'Lounge',
    'Lockers',
    'Gym'
  ];
  RxBool isFullScreen = false.obs;
  Rx<YoutubePlayerController>? videoController;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    userId = MySharedPref.getid();
    userName = MySharedPref.getName();
    token = MySharedPref.getauthtoken();
    Map params = Get.parameters;
    var id = params["id"];
    debugPrint("params $params, id $id ");
    await getVenueDetails(id);
    isLoading = false;
    update();
  }

  Future<void> getVenueDetails(id) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "id": id.toString()
    };

    await ApiService.getVenueDetails(data).then((response) async {
      VenueDetails? res = venueDetailsFromJson(response);
      debugPrint("IN hEEre1");
      if (res!.status!) {
        debugPrint("IN hEEre");
        print(res.data![0].userId);
        venues!.addAll(res.data!);
        if (venues!.isNotEmpty) {
          venueName = venues![0]!.title!;
          venueDescription = venues![0]!.description!;
          venueAdd = venues![0]!.address!;
          if (venues![0]!.amenitiesDetails != null &&
              venues![0]!.amenitiesDetails!.isNotEmpty) {
            for (var i = 0; i < venues![0]!.amenitiesDetails!.length; i++) {
              amenities!.add(venues![0]!.amenitiesDetails![i].name!.toString());
            }
          }
          try {
            if (venues![0]!.videoUrl != null) {
              if (venues![0]!.videoUrl != "null") {
                videoUrl(venues![0]!.videoUrl);
                videoController = YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(videoUrl.value)!,
                  flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      hideControls: false,
                      disableDragSeek: true),
                ).obs;
              }
            }
          } catch (e) {}

          if (venues![0]!.sportsDetails!.isNotEmpty) {
            venues![0]!.sportsDetails?.forEach((element) {
              print(element.sportName);
              selectedSports?.add(element.sportName ?? "");
            });
          }

          if (venues![0]!.facilities!.isNotEmpty) {
            // facilites!.addAll(venues![0]!.facilities!);
            for (Facility facility in venues![0]!.facilities!) {
              String title = facility.title ?? "";

              // If the title is not already in the map, create a new list for it.
              if (!groupedFacilities.containsKey(title)) {
                groupedFacilities[title] = [];
                facilites!.add(facility);
                print(facilites);
              }

              // Add the facility to the list for the title.
              else {
                groupedFacilities[title]!.add(facility);
              }
            }
          }
          if (venues![0]!.latitude!.isNotEmpty) {
            lat = venues![0]!.latitude!;
          }
          if (venues![0]!.longitude!.isNotEmpty) {
            lng = venues![0]!.longitude!;
          }

          if (venues![0]!.rating!.isNotEmpty) {
            String? rate =
                venues!.first!.rating!.first.rating.toString().trim();
            if (rate.isNotEmpty) {
              dynamic rating = double.parse(rate);
              actualRating = rating;
            }
          }
        }
        await getVenueImgs(id);
        if (images.isEmpty) {
          images.add((venues![0]!.image!));
        }
        debugPrint(" venue ${venues!.length},  ");
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

  Future<void> getVenueImgs(id) async {
    var data = {
      "userid": userId.toString(),
      "token": token,
      "post_id": id.toString(),
      "post_type": "venue"
    };

    await ApiService.getMedial(data).then((response) {
      m.MediaResponseModel? res = m.mediaResponseModelFromJson(response);
      debugPrint("IN hEEre1");
      if (res.status!) {
        debugPrint("IN hEEre");
        images.clear();
        for (var i = 0; i < res.data!.length; i++) {
          images.add(res.data![i].image!);
        }
      } else {
        debugPrint("IN hEEre3");
        //Get.snackbar("Error", "${res.message}");
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("IN hEEr4 ${error.toString()}");
      Get.snackbar("Error", error.toString());
    });
  }
}
