// To parse this JSON data, do
//
//     final experienceDetails = experienceDetailsFromJson(jsonString);

import 'dart:convert';
// import 'dart:js_util';

ExperienceDetails? experienceDetailsFromJson(String str) => ExperienceDetails.fromJson(json.decode(str));

String experienceDetailsToJson(ExperienceDetails data) => json.encode(data.toJson());

class ExperienceDetails {
    ExperienceDetails({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory ExperienceDetails.fromJson(Map<String, dynamic> json) => ExperienceDetails(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : json["data"] is List ? List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))):[],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.title,
        this.user_id,
        this.description,
        this.price,
        this.venueId,
        this.image,
        this.status,
        this.address,
        this.time,
        this.createdAt,
        this.updatedAt,
        this.rating,
    });

    String? id;
    String? title;
    String? description;
    String? price;
    String? venueId;
    String? image;
    String? user_id;
    String? status;
    String? time;
    String? address;
    String? createdAt;
    String? updatedAt;
    List<RatingElement>? rating;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"]??"",
        description: json["description"]??"",
        price: json["price"]??"",
        venueId: json["venue_id"],
        image: json["image"],
        status: json["status"],
        address: json['address'],
        time:json["start_time"],
        user_id: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rating: json["rating"] == null ? [] : json["rating"] is List ? List<RatingElement>.from(json["rating"]!.map((x) => RatingElement.fromJson(x))):[],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "venue_id": venueId,
        "image": image,
        "user_id":user_id,
        "status": status,
        "address":address,
        "start_time":time,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "rating": rating,
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
        rating: json["rating"]??"1",
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

