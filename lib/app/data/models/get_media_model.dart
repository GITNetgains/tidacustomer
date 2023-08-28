// To parse this JSON data, do
//
//     final mediaResponseModel = mediaResponseModelFromJson(jsonString);

import 'dart:convert';

MediaResponseModel mediaResponseModelFromJson(String str) => MediaResponseModel.fromJson(json.decode(str));

String mediaResponseModelToJson(MediaResponseModel data) => json.encode(data.toJson());

class MediaResponseModel {
    MediaResponseModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory MediaResponseModel.fromJson(Map<String, dynamic> json) => MediaResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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
        this.name,
        this.image,
        this.postId,
        this.postType,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? name;
    String? image;
    String? postId;
    String? postType;
    String? status;
    String? createdAt;
    String? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        postId: json["post_id"],
        postType: json["post_type"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "post_id": postId,
        "post_type": postType,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
