// To parse this JSON data, do
//
//     final timeBack = timeBackFromJson(jsonString);

import 'dart:convert';

List<TimeBack> timeBackFromJson(String str) =>
    List<TimeBack>.from(json.decode(str).map((x) => TimeBack.fromJson(x)));

String timeBackToJson(List<TimeBack> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeBack {
  TimeBack({
    required this.timeBackId,
    required this.timeB,
  });

  int timeBackId;
  DateTime timeB;

  factory TimeBack.fromJson(Map<String, dynamic> json) => TimeBack(
        timeBackId: json["TimeBackID"],
        timeB: DateTime.parse(json["TimeB"]),
      );

  Map<String, dynamic> toJson() => {
        "TimeBackID": timeBackId,
        "TimeB": timeB.toIso8601String(),
      };
}
