import 'dart:async';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:bus/model/traveler.dart';
import 'package:bus/model/travels_for_travelers_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/destination_back_model.dart';
import '../model/destination_go_model.dart';
import '../model/time_back.dart';
import '../model/time_go.dart';
import '../model/travel_model.dart';

enum EditTravelerState { intializing, loading, loaded, failed, notConnected,success }

class EditTravelerViewModel extends ChangeNotifier {
  Traveler? traveler;

  List<dynamic>? travels;
  String? time;

  EditTravelerState state = EditTravelerState.intializing;
  String errorMessage = '';
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  fetchTravelsByTraveler() async {
    var params = {'UserId': sharedPref!.getString('userID')};

    Dio dio = Dio();
    try {
      var response = await dio.get('$baseUrl/api/Travelers/GetTravelersTarvel',
          queryParameters: params);
      if (response.statusCode == 200) {
        var data = await response.data;

        return data.map((e) => TravelsForTravelers.fromJson(e)).toList();
      }
    } on SocketException {
      errorMessage = "Not connected";
      setState(EditTravelerState.notConnected);
      // notifyListeners();

      return [];
    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(EditTravelerState.failed);
      // notifyListeners();

      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      // notifyListeners();

      return [];
    }
  }

  getTravels() async {
    travels = await fetchTravelsByTraveler();
    return travels;
  }

  deleteTraveler(int id) async {
    Dio dio = Dio();
    final params = {'id': id};
    try {
final response = await dio.delete('$baseUrl/api/Travelers',queryParameters: params);
      notifyListeners();
    } on SocketException {
      errorMessage = "Not connected";
      setState(EditTravelerState.notConnected);
      return [];
    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(EditTravelerState.failed);
      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      return [];
    }
  }

  fetchTraveler(int id) async {
    var params = {'id': id};

    Dio dio = Dio();
    try {
      var response = await dio.get('$baseUrl/api/Travelers/GetTraveler',
          queryParameters: params);
      if (response.statusCode == 200) {
        var stringObject = Map<String, dynamic>.from(response.data);

        // final item = json.decode(response.data);
        return Traveler.fromJson(stringObject);
      }
    } on SocketException {
      errorMessage = "Not connected";
      setState(EditTravelerState.notConnected);
      // notifyListeners();

    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(EditTravelerState.failed);
      // notifyListeners();

    } on DioError catch (e) {
      _handleDioErrors(e);
      // notifyListeners();

    }
  }

  getTraveler(int id) async {
    traveler = await fetchTraveler(id);
    return traveler;
  }

  fetchTime(String id) async {
    Dio dio = Dio();
    var params = {'TravelID': id};
    var response = await dio.get('$baseUrl/api/Travels/GetTravelsDate',
        queryParameters: params);

    return response.data.toString();
  }

  getTime(String id) async {
    time = await fetchTime(id);
    return time;
  }

  int selectedSchedule = 0;
  String? selectedScheduleName;
  int? selectedDestGoID;
  int? selectedDestBackID;
  int? selectedTimeGoID;
  int? selectedTimeBackID;

  bool loading = false;
  Travel? travel;

  List<dynamic>? timeGo;
  List<dynamic>? timeBack;
  bool isOn = false;
  List<dynamic> destGoList = [];
  List<dynamic> destBackList = [];

  final List scheduleList = [
    "Go only",
    "Back only"
        "Both"
  ];

  dropCheck(String val, int travelId) {
    selectedScheduleName = val;
    if (val == "Go only") {
      selectedSchedule = 0;
      fetchDestGo(travelId);
    } else if (selectedScheduleName == "Back only") {
      selectedSchedule = 1;
      fetchDestBack(travelId);
    } else if (selectedScheduleName == "Both") {
      selectedSchedule = 2;
      fetchDestGo(travelId);
      fetchDestBack(travelId);
    }
    notifyListeners();
  }

  getTravel(int travelId) async {
    travel = await fetchTravel(travelId);
    return travel;
  }

  Future<Travel?> fetchTravel(int id) async {
    Travel? result;

    try {
      var params = {'id': id};
      // final response =
      //     await http.get(Uri.parse("$baseUrl/api/Travels?id=66"), headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      // });
      Dio dio = Dio();
      var response = await dio.get("$baseUrl/api/Travels/GetTravelByid",
          queryParameters: params);
      // var response = await http.get(Uri.parse("$baseUrl/api/Travels?id=66"));
      // var body = jsonDecode(response.data);
      //  stringObject = response.data;

      if (response.statusCode == 200) {
        var stringObject = Map<String, dynamic>.from(response.data);

        // final item = json.decode(response.data);
        result = Travel.fromJson(stringObject);
        return result;
      } else {}
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

  Future<List<dynamic>> fetchDestBack(int travelId) async {
    var params = {
      'TravelID': travelId,
    };
    final Dio dio = Dio();
    var response =
        await dio.get("$baseUrl/api/DestinationBacks", queryParameters: params);

    //    var stringObject = Map<String, dynamic>.from(response.data);
    //  var s=  DestinationGoModel.fromJson(stringObject);
    // var data = response.data;
    //   var stringObject = Map<String, dynamic>.from(response.data);
    // result = DestinationBackModel.fromJson(stringObject);
    // var response = await http.get(Uri.parse("$baseUrl/api/DestinationBacks"));
    // var result=jsonDecode(data);
    if (response.statusCode == 200) {
      // var jsonString = response.body;
      var data = await response.data;

      return data.map((e) => DestinationBackModel.fromJson(e)).toList();
      //  (data as List).map((e) => DestinationGoModel.fromJson(e)).toList();

      // destinationBackModelFromJson(result);
      // return s;

    } else {
      return [];
    }
  }

  Future<List<dynamic>> fetchDestGo(int travelId) async {
    var params = {
      'TravelID': travelId,
    };
    final Dio dio = Dio();
    var response =
        await dio.get("$baseUrl/api/DestinationGoes", queryParameters: params);

    //    var stringObject = Map<String, dynamic>.from(response.data);
    //  var s=  DestinationGoModel.fromJson(stringObject);
    // var data = response.data;
    //   var stringObject = Map<String, dynamic>.from(response.data);
    // result = DestinationBackModel.fromJson(stringObject);
    // var response = await http.get(Uri.parse("$baseUrl/api/DestinationBacks"));
    // var result=jsonDecode(data);
    if (response.statusCode == 200) {
      // var jsonString = response.body;
      var data = await response.data;

      return data.map((e) => DestinationGoModel.fromJson(e)).toList();
      //  (data as List).map((e) => DestinationGoModel.fromJson(e)).toList();

      // destinationBackModelFromJson(result);
      // return s;

    } else {
      return [];
    }
  }

  getDestGo(int travelId) async {
    destGoList = await fetchDestGo(travelId);
    return destGoList;
  }

  getDestBack(int travelId) async {
    destBackList = await fetchDestBack(travelId);
    return destBackList;
  }

  editTraveler(
      BuildContext context, String codeNum, int travelId, int id) async {
    var params = {
      'TravelID': travelId,
      // 'id': sharedPref!.getString('userID').toString(),
      'id': id,

      'DestinationGoID': selectedDestGoID?.toString() ?? "0",
      'DestinationBackID': selectedDestBackID?.toString() ?? "0",
      'TimeGoID': selectedTimeGoID?.toString() ?? "0",
      'TimeBackID': selectedTimeBackID?.toString() ?? "0",
      'ReferenceNo': codeNum
    };
    var dio = Dio();
    try {
      setState(EditTravelerState.loading);
      var response =
          await dio.put("$baseUrl/api/Travelers", queryParameters: params);
      if (response.statusCode == 200) {
        errorMessage="Edited Successfully";
              setState(EditTravelerState.success);

notifyListeners();
      }

//   final Uri url=Uri.parse("http://icecode-001-site1.itempurl.com//api/Travels");
//  var bytes = img!.readAsBytesSync();

// http.MultipartRequest request = new http.MultipartRequest("POST", url);

      // if (response.statusCode == 201) {
      //   loading = false;
      // } else {
      //   loading = false;
      //   notifyListeners();
      // }

    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(EditTravelerState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(EditTravelerState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(EditTravelerState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(EditTravelerState.failed);
    }
  }

 Future<dynamic> fetchTimesGo(int destId) async {
    List<dynamic> time=[];
    var params = {
      'DestinationGoID': destId,
    };

    try {
      Dio dio = Dio();
      var response =
          await dio.get("$baseUrl/api/TimeGoes", queryParameters: params);

      if (response.statusCode == 200) {
        var data = response.data;
          // Map<String, dynamic> responseJson = json.decode(response.data.toString());
          // return TimeGo.fromJson(responseJson);
        // var jsonBody= json.decode(data);
        // for(var data in jsonBody){
        //   TimeGo obj = TimeGo(timeGoId: data['timeGoId'], time: data['time']);
        //   time.add(obj);
        // }
        // time=timeGoFromJson(data);
        time = data.map((e) => TimeGo.fromJson(e)).toList() ;
return time[0];
        // times?.add( time![0]);
      } 
      else {
        print('error');
        print(response.data);
      }
    } catch (e) {
      rethrow;
    }
    return time[0];
  }

  Future<dynamic> fetchTimesBack(int destId) async {
    List<dynamic> time=[];
    var params = {
      'DestinationBackID': destId,
    };

    try {
      Dio dio = Dio();
      var response =
          await dio.get("$baseUrl/api/TimeBacks", queryParameters: params);

      if (response.statusCode == 200) {
        var data = response.data;
        time = data.map((e) => TimeBack.fromJson(e)).toList();

        return time[0];
      }
    // } on SocketException {
    //   errorMessage = "PLease check your connection";
    //   setState(TravelInfoState.failed);
    // } on FormatException {
    //   errorMessage = "Error happened try agian later";
    //   setState(TravelInfoState.failed);
    // } on TimeoutException {
    //   errorMessage = "Your internet connection is bad please try agian later";
    //   setState(TravelInfoState.failed);
    // } on DioError catch (e) {
    //   _handleDioErrors(e);
    // } catch (e) {
    //   errorMessage = "Please fill the data";
    //   setState(TravelInfoState.failed);
    // }
      else {
        print('error');
        print(response.data);
      }
    } catch (e) {
      rethrow;
    }
    return time[0];
  }

  getTimeGo(int destId) async {
    timeGo = await fetchTimesGo(destId);
    notifyListeners();
  }

  getTimeBack(int destId) async {
    timeBack = await fetchTimesBack(destId);
    notifyListeners();
  }

  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(EditTravelerState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(EditTravelerState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(EditTravelerState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(EditTravelerState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(EditTravelerState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(EditTravelerState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(EditTravelerState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(EditTravelerState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
