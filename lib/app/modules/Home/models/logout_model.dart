// To parse this JSON data, do
//
//     final logoutResponseModel = logoutResponseModelFromJson(jsonString);

import 'dart:convert';

LogoutResponseModel logoutResponseModelFromJson(String str) => LogoutResponseModel.fromJson(json.decode(str));

String logoutResponseModelToJson(LogoutResponseModel data) => json.encode(data.toJson());

class LogoutResponseModel {
    LogoutResponseModel({
        this.status,
        this.data,
        this.message,
    });

    bool? status;
    dynamic data;
    String? message;

    factory LogoutResponseModel.fromJson(Map<String, dynamic> json) => LogoutResponseModel(
        status: json["status"],
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
    };
}
