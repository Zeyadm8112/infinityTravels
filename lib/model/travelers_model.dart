// To parse this JSON data, do
//
//     final travelersModel = travelersModelFromJson(jsonString);

import 'dart:convert';

List<TravelersModel> travelersModelFromJson(String str) => List<TravelersModel>.from(json.decode(str).map((x) => TravelersModel.fromJson(x)));

String travelersModelToJson(List<TravelersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravelersModel {
    TravelersModel({
  required     this.id,
     required   this.userName,
        this.destinationName,
        this.destinationNameB,
       required this.phoneNumber,
       required this.referenceNo,
    });

    int id;
    String userName;
    String? destinationName;
    String? destinationNameB;
    String phoneNumber;
    String referenceNo;

    factory TravelersModel.fromJson(Map<String, dynamic> json) => TravelersModel(
        id: json["id"],
        userName: json["UserName"],
        destinationName: json["DestinationName"],
        destinationNameB: json["DestinationNameB"],
        phoneNumber: json["PhoneNumber"],
        referenceNo: json["ReferenceNo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "UserName": userName,
        "DestinationName": destinationName,
        "DestinationNameB": destinationNameB,
        "PhoneNumber": phoneNumber,
        "ReferenceNo": referenceNo,
    };
}
