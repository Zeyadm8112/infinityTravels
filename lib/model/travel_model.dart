// To parse this JSON data, do
//
//     final travel = travelFromJson(jsonString);

import 'dart:convert';

Travel travelFromJson(String str) => Travel.fromJson(json.decode(str));

String travelToJson(Travel data) => json.encode(data.toJson());

class Travel {
  Travel({
    required this.travelId,
    required this.travelName,
    required this.userName,
    required this.noOfSites,
    required this.travelDescription,
    required this.travelAppointment,
    required this.imagePath,
  });

  int travelId;
  String travelName;
  String userName;
  int noOfSites;
  String travelDescription;
  String travelAppointment;
  String imagePath;

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        travelId: json["TravelID"],
        travelName: json["TravelName"],
        userName: json["UserName"],
        noOfSites: json["NoOfSites"],
        travelDescription: json["TravelDescription"],
        travelAppointment: json["TravelAppointment"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "TravelID": travelId,
        "TravelName": travelName,
        "UserName": userName,
        "NoOfSites": noOfSites,
        "TravelDescription": travelDescription,
        "TravelAppointment": travelAppointment,
        "ImagePath": imagePath,
      };
}
