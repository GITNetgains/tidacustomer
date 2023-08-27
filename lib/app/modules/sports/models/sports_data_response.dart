// To parse this JSON data, do
//
//     final sportsDataResponse = sportsDataResponseFromJson(jsonString);

import 'dart:convert';

SportsDataResponse? sportsDataResponseFromJson(String str) => SportsDataResponse.fromJson(json.decode(str));

String sportsDataResponseToJson(SportsDataResponse? data) => json.encode(data!.toJson());

class SportsDataResponse {
    SportsDataResponse({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum?>? data;

    factory SportsDataResponse.fromJson(Map<String, dynamic> json) => SportsDataResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.sportName,
        this.sportIcon,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? sportName;
    String? sportIcon;
    String? status;
    String? createdAt;
    String? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sportName: json["sport_name"],
        sportIcon: json["sport_icon"]??"",
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sport_name": sportName,
        "sport_icon": sportIcon,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
