// To parse this JSON data, do
//
//     final destinationModel = destinationModelFromJson(jsonString);

import 'dart:convert';

DestinationModel destinationModelFromJson(String str) =>
    DestinationModel.fromJson(json.decode(str));

String destinationModelToJson(DestinationModel data) =>
    json.encode(data.toJson());

class DestinationModel {
  DestinationModel({
    required this.destinationGoId,
    required this.destinationName,
    required this.travelId,
    required this.travel,
    required this.timeGoes,
    required this.travelers,
  });

  int destinationGoId;
  String destinationName;
  int travelId;
  dynamic travel;
  List<dynamic> timeGoes;
  List<dynamic> travelers;

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        destinationGoId: json["DestinationGoID"],
        destinationName: json["DestinationName"],
        travelId: json["TravelID"],
        travel: json["Travel"],
        timeGoes: List<dynamic>.from(json["TimeGoes"].map((x) => x)),
        travelers: List<dynamic>.from(json["Travelers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "DestinationGoID": destinationGoId,
        "DestinationName": destinationName,
        "TravelID": travelId,
        "Travel": travel,
        "TimeGoes": List<dynamic>.from(timeGoes.map((x) => x)),
        "Travelers": List<dynamic>.from(travelers.map((x) => x)),
      };
}
