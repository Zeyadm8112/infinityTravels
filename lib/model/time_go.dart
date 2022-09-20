// To parse this JSON data, do
//
//     final timeGo = timeGoFromJson(jsonString);

import 'dart:convert';

List<TimeGo> timeGoFromJson(String str) =>
    List<TimeGo>.from(json.decode(str).map((x) => TimeGo.fromJson(x)));

String timeGoToJson(List<TimeGo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeGo {
  TimeGo({
    required this.timeGoId,
    required this.time,
  });

  int timeGoId;
  DateTime time;

  factory TimeGo.fromJson(Map<String, dynamic> json) => TimeGo(
        timeGoId: json["TimeGoID"],
        time: DateTime.parse(json["Time"]),
      );

  Map<String, dynamic> toJson() => {
        "TimeGoID": timeGoId,
        "Time": time.toIso8601String(),
      };
}
