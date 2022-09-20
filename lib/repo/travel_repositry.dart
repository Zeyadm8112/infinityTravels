import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:bus/consts/constants.dart';
import 'package:bus/model/travel_model.dart';

class TravelRepositry {
  static 
  Future<Travel?> fetchTravel(int id) async {
    Travel? result;

    try {
      var params = {'id': id};
      // final response =
      //     await http.get(Uri.parse("$baseUrl/api/Travels?id=66"), headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      // });
      Dio dio = Dio();
      var response = await dio.get(
        "$baseUrl/api/Travels/GetTravelByid",
         queryParameters: params
      );
      // var response = await http.get(Uri.parse("$baseUrl/api/Travels?id=66"));
      // var body = jsonDecode(response.data);
      //  stringObject = response.data;

      if (response.statusCode == 200) {
        var stringObject = Map<String, dynamic>.from(response.data);

        // final item = json.decode(response.data);
        result = Travel.fromJson(stringObject);
        return result;
        print(response.data);
      } else {
        print('error');
        print(response.data);
      }
    } catch (e) {
      rethrow;
    }
    return result;
    // var stringObject = Map<String, dynamic>.from(response.data);
    // result = Travel.fromJson(stringObject);
    // this.result = result;
    // notifyListeners();
    // var stringObject = response.data;

    //  var s=  DestinationGoModel.fromJson(stringObject);
    // var data = response.data;
    // var stringObject = Map<String, dynamic>.from(response.data);

    // if (response.statusCode == 200) {
    //   result = Travel.fromJson(body);
    //   // this.result = result;
    //   // notifyListeners();
    //   return result;
    // } else {
    //   print('${response.statusCode} : ${response.body.toString()}');
    //   throw "error";
    // }
  }
}
