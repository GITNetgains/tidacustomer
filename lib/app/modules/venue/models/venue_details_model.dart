// To parse this JSON data, do
//
//     final venueDetails = venueDetailsFromJson(jsonString);

import 'dart:convert';

VenueDetails? venueDetailsFromJson(String str) =>
    VenueDetails.fromJson(json.decode(str));

String venueDetailsToJson(VenueDetails data) => json.encode(data.toJson());

class VenueDetails {
  VenueDetails({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory VenueDetails.fromJson(Map<String, dynamic> json) => VenueDetails(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : json["data"] is List
                ? List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x)))
                : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.image,
    this.title,
    this.sports,
    this.amenities,
    this.description,
    this.address,
    this.addressMap,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.facilities,
    this.rating,
    this.distance,
    this.videoUrl,
    this.sportsDetails,
    this.amenitiesDetails,
  });

  String? id;
  String? userId;
  String? image;
  String? title;
  String? sports;
  String? amenities;
  String? description;
  String? address;
  String? distance;
  String? addressMap;
  String? latitude;
  String? longitude;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? videoUrl;
  List<Facility>? facilities;
  List<RatingElement>? rating;
  List<SportsDetail>? sportsDetails;
  List<AmenitiesDetail>? amenitiesDetails;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        image: json["image"],
        title: json["title"] ?? "",
        sports: json["sports"],
        amenities: json["amenities"],
        description: json["description"] ?? "",
        address: json["address"] ?? "",
        addressMap: json["address_map"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: json["created_at"],
        videoUrl: json["video_url"],
        distance: json["distance"],
        updatedAt: json["updated_at"],
        facilities: json["facilities"] == null
            ? []
            : json["facilities"] is List
                ? List<Facility>.from(
                    json["facilities"]!.map((x) => Facility.fromJson(x)))
                : [],
        rating: json["rating"] == null
            ? []
            : json["rating"] is List
                ? List<RatingElement>.from(
                    json["rating"]!.map((x) => RatingElement.fromJson(x)))
                : [],
        sportsDetails: json["sports_details"] == null
            ? []
            : json["sports_details"] is List
                ? List<SportsDetail>.from(json["sports_details"]!
                    .map((x) => SportsDetail.fromJson(x)))
                : [],
        amenitiesDetails: json["amenities_details"] == null
            ? []
            : json["amenities_details"] is List
                ? List<AmenitiesDetail>.from(json["amenities_details"]!
                    .map((x) => AmenitiesDetail.fromJson(x)))
                : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "image": image,
        "title": title,
        "sports": sports,
        "amenities": amenities,
        "description": description,
        "address": address,
        "address_map": addressMap,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_at": createdAt,
        "video_url": videoUrl,
        "updated_at": updatedAt,
        "distance": distance,
        "facilities": facilities,
        "rating": rating == null
            ? []
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
        "sports_details": sportsDetails == null
            ? []
            : List<dynamic>.from(sportsDetails!.map((x) => x.toJson())),
        "amenities_details": amenitiesDetails == null
            ? []
            : List<dynamic>.from(amenitiesDetails!.map((x) => x.toJson())),
      };
}

class AmenitiesDetail {
  AmenitiesDetail({
    this.id,
    this.name,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? icon;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory AmenitiesDetail.fromJson(Map<String, dynamic> json) =>
      AmenitiesDetail(
        id: json["id"],
        name: json["name"] ?? "",
        icon: json["icon"] ?? "",
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Facility {
  Facility({
    this.id,
    this.title,
    this.venueId,
    this.noOfInventories,
    this.minPlayers,
    this.maxPlayers,
    this.defaultPlayers,
    this.pricePerSlot,
    this.openingTime,
    this.closingTime,
    this.available24Hours,
    this.slotLengthHrs,
    this.slotLengthMin,
    this.slotFrequency,
    this.activity,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? venueId;
  String? noOfInventories;
  String? minPlayers;
  String? maxPlayers;
  String? defaultPlayers;
  String? pricePerSlot;
  String? openingTime;
  String? closingTime;
  String? available24Hours;
  String? slotLengthHrs;
  String? slotLengthMin;
  String? slotFrequency;
  String? activity;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        id: json["id"],
        title: json["title"] ?? "",
        venueId: json["venue_id"],
        noOfInventories: json["no_of_inventories"],
        minPlayers: json["min_players"],
        maxPlayers: json["max_players"],
        defaultPlayers: json["default_players"],
        pricePerSlot: json["price_per_slot"] ?? "",
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        available24Hours: json["available_24_hours"],
        slotLengthHrs: json["slot_length_hrs"],
        slotLengthMin: json["slot_length_min"],
        slotFrequency: json["slot_frequency"],
        activity: json["activity"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "venue_id": venueId,
        "no_of_inventories": noOfInventories,
        "min_players": minPlayers,
        "max_players": maxPlayers,
        "default_players": defaultPlayers,
        "price_per_slot": pricePerSlot,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "available_24_hours": available24Hours,
        "slot_length_hrs": slotLengthHrs,
        "slot_length_min": slotLengthMin,
        "slot_frequency": slotFrequency,
        "activity": activity,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class RatingElement {
  RatingElement({
    this.id,
    this.userId,
    this.review,
    this.rating,
    this.postType,
    this.postId,
    this.status,
    this.createdAt,
  });

  String? id;
  String? userId;
  String? review;
  String? rating;
  String? postType;
  String? postId;
  String? status;
  String? createdAt;

  factory RatingElement.fromJson(Map<String, dynamic> json) => RatingElement(
        id: json["id"],
        userId: json["user_id"],
        review: json["review"],
        rating: json["rating"] ?? "1",
        postType: json["post_type"],
        postId: json["post_id"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "review": review,
        "rating": rating,
        "post_type": postType,
        "post_id": postId,
        "status": status,
        "created_at": createdAt,
      };
}

class SportsDetail {
  SportsDetail({
    this.id,
    this.sportName,
    this.sportPrice,
    this.sportIcon,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? sportName;
  String? sportPrice;
  String? sportIcon;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory SportsDetail.fromJson(Map<String, dynamic> json) => SportsDetail(
        id: json["id"],
        sportName: json["sport_name"] ?? "",
        sportPrice: json["sport_price"] ?? "",
        sportIcon: json["sport_icon"] ?? "",
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_name": sportName,
        "sport_price": sportPrice,
        "sport_icon": sportIcon,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
