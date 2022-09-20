// To parse this JSON data, do
//
//     final travelsForTravelers = travelsForTravelersFromJson(jsonString);

import 'dart:convert';

List<TravelsForTravelers> travelsForTravelersFromJson(String str) => List<TravelsForTravelers>.from(json.decode(str).map((x) => TravelsForTravelers.fromJson(x)));

String travelsForTravelersToJson(List<TravelsForTravelers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravelsForTravelers {
    TravelsForTravelers({
    required    this.id,
   required     this.travelId,
  required      this.travelName,
  required     this.userCreatorId,
   required     this.travelDescription,
  required      this.travelAppointment,
    });

    int id;
    int travelId;
    String travelName;
    String userCreatorId;
    String travelDescription;
    String travelAppointment;

    factory TravelsForTravelers.fromJson(Map<String, dynamic> json) => TravelsForTravelers(
        id: json["id"],
        travelId: json["TravelID"],
        travelName: json["TravelName"],
        userCreatorId: json["UserCreatorID"],
        travelDescription: json["TravelDescription"],
        travelAppointment: json["TravelAppointment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "TravelID": travelId,
        "TravelName": travelName,
        "UserCreatorID": userCreatorId,
        "TravelDescription": travelDescription,
        "TravelAppointment": travelAppointment,
    };
}
