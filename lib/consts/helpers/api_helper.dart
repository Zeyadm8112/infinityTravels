import 'dart:convert';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/consts/httpresponse.dart';
import 'package:bus/model/travel_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<HTTPResponse<Travel>?> fetchTravel(int id) async {
    Response? response;
    try {
      try {
        response = await http.get(Uri.parse("$baseUrl/api/Travels?id=$id"));
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var result = Travel.fromJson(body);
          return HTTPResponse(true, result,
              message: " ", responseCode: response.statusCode);
        }
      } on SocketException {
        return HTTPResponse(false, null,
            message: " Please check your internet",
            responseCode: response!.statusCode);
      } on FormatException {
        return HTTPResponse(false, null,
            message: " Something went wrong try agian later",
            responseCode: response!.statusCode);
      } catch (e) {
        return HTTPResponse(false, null,
            message: " Something went wrong try agian later",
            responseCode: response!.statusCode);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
