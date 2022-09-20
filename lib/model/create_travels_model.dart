// To parse this JSON data, do
//
//     final createTravelModel = createTravelModelFromJson(jsonString);

import 'dart:convert';

CreateTravelModel createTravelModelFromJson(String str) =>
    CreateTravelModel.fromJson(json.decode(str));

String createTravelModelToJson(CreateTravelModel data) =>
    json.encode(data.toJson());

class CreateTravelModel {
  CreateTravelModel({
    required this.travelId,
    required this.travelName,
    required this.userCreatorId,
    required this.noOfSites,
    required this.travelDescription,
    required this.travelAppointment,
    required this.imagePath,
    required this.destinationBacks,
    required this.destinationGoes,
    required this.travelers,
    this.aspNetUser,
  });

  int travelId;
  String travelName;
  String userCreatorId;
  int noOfSites;
  String travelDescription;
  String travelAppointment;
  String imagePath;
  List<dynamic> destinationBacks;
  List<dynamic> destinationGoes;
  List<dynamic> travelers;
  dynamic aspNetUser;

  factory CreateTravelModel.fromJson(Map<String, dynamic> json) =>
      CreateTravelModel(
        travelId: json["TravelID"],
        travelName: json["TravelName"],
        userCreatorId: json["UserCreatorID"],
        noOfSites: json["NoOfSites"],
        travelDescription: json["TravelDescription"],
        travelAppointment: json["TravelAppointment"],
        imagePath: json["ImagePath"],
        destinationBacks:
            List<dynamic>.from(json["DestinationBacks"].map((x) => x)),
        destinationGoes:
            List<dynamic>.from(json["DestinationGoes"].map((x) => x)),
        travelers: List<dynamic>.from(json["Travelers"].map((x) => x)),
        aspNetUser: json["AspNetUser"],
      );

  Map<String, dynamic> toJson() => {
        "TravelID": travelId,
        "TravelName": travelName,
        "UserCreatorID": userCreatorId,
        "NoOfSites": noOfSites,
        "TravelDescription": travelDescription,
        "TravelAppointment": travelAppointment,
        "ImagePath": imagePath,
        "DestinationBacks": List<dynamic>.from(destinationBacks.map((x) => x)),
        "DestinationGoes": List<dynamic>.from(destinationGoes.map((x) => x)),
        "Travelers": List<dynamic>.from(travelers.map((x) => x)),
        "AspNetUser": aspNetUser,
      };
}
