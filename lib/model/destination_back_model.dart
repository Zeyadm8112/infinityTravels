// To parse this JSON data, do
//
//     final destinationBackModel = destinationBackModelFromJson(jsonString);

import 'dart:convert';

List<DestinationBackModel> destinationBackModelFromJson(String str) => List<DestinationBackModel>.from(json.decode(str).map((x) => DestinationBackModel.fromJson(x)));

String destinationBackModelToJson(List<DestinationBackModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationBackModel {
    DestinationBackModel({
       required this.destinationBackId,
      required   this.destinationNameB,
    });

    int destinationBackId;
    String destinationNameB;

    factory DestinationBackModel.fromJson(Map<String, dynamic> json) => DestinationBackModel(
        destinationBackId: json["DestinationBackID"],
        destinationNameB: json["DestinationNameB"],
    );

    Map<String, dynamic> toJson() => {
        "DestinationBackID": destinationBackId,
        "DestinationNameB": destinationNameB,
    };
}
