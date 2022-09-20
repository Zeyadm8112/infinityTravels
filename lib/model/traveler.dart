// To parse this JSON data, do
//
//     final traveler = travelerFromJson(jsonString);

import 'dart:convert';

Traveler travelerFromJson(String str) => Traveler.fromJson(json.decode(str));

String travelerToJson(Traveler data) => json.encode(data.toJson());

class Traveler {
    Traveler({
   required   this.userName,
    required    this.travelName,
        this.destinationName,
        this.time,
        this.destinationNameB,
        this.timeB,
     required   this.referenceNo,
    });

    String userName;
    String travelName;
    String? destinationName;
    String? time;
    String? destinationNameB;
    String? timeB;
    String referenceNo;

    factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
        userName: json["UserName"],
        travelName: json["TravelName"],
        destinationName: json["DestinationName"],
        time: json["Time"],
        destinationNameB: json["DestinationNameB"],
        timeB: json["TimeB"],
        referenceNo: json["ReferenceNo"],
    );

    Map<String, dynamic> toJson() => {
        "UserName": userName,
        "TravelName": travelName,
        "DestinationName": destinationName,
        "Time": time,
        "DestinationNameB": destinationNameB,
        "TimeB": timeB,
        "ReferenceNo": referenceNo,
    };
}
