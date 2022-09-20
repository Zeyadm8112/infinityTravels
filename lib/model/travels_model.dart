// To parse this JSON data, do
//
//     final travelsModel = travelsModelFromJson(jsonString);

import 'dart:convert';

List<TravelsModel> travelsModelFromJson(String str) => List<TravelsModel>.from(
    json.decode(str).map((x) => TravelsModel.fromJson(x)));

String travelsModelToJson(List<TravelsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravelsModel {
  TravelsModel({
     this.travelId,
     this.travelName,
     this.userCreatorId,
     this.noOfSites,
     this.travelDescription,
     this.travelAppointment,
     this.imagePath,
  });

  int? travelId;
  String? travelName;
  String? userCreatorId;
  int? noOfSites;
  String? travelDescription;
  String? travelAppointment;
  String? imagePath;

  factory TravelsModel.fromJson(Map<String, dynamic> json) => TravelsModel(
        travelId: json["TravelID"],
        travelName: json["TravelName"],
        userCreatorId: json["UserCreatorID"],
        noOfSites: json["NoOfSites"],
        travelDescription: json["TravelDescription"],
        travelAppointment: json["TravelAppointment"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "TravelID": travelId,
        "TravelName": travelName,
        "UserCreatorID": userCreatorId,
        "NoOfSites": noOfSites,
        "TravelDescription": travelDescription,
        "TravelAppointment": travelAppointment,
        "ImagePath": imagePath,
      };
}
