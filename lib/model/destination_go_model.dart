// To parse this JSON data, do
//
//     final destinationGoModel = destinationGoModelFromJson(jsonString);

import 'dart:convert';

List<DestinationGoModel> destinationGoModelFromJson(String str) => List<DestinationGoModel>.from(json.decode(str).map((x) => DestinationGoModel.fromJson(x)));

String destinationGoModelToJson(List<DestinationGoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationGoModel {
  int? destinationGoID;
  String? destinationName;

  DestinationGoModel({this.destinationGoID, this.destinationName});

  DestinationGoModel.fromJson(Map<String, dynamic> json) {
    destinationGoID = json['DestinationGoID'];
    destinationName = json['DestinationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DestinationGoID'] = this.destinationGoID;
    data['DestinationName'] = this.destinationName;
    return data;
  }
}