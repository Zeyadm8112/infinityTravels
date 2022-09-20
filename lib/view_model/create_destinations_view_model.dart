import 'dart:async';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/model/destination_go_model.dart';
import 'package:bus/view/screens/manager/dashboard/create_destinations_screen.dart';
import 'package:bus/view_model/create_times_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

import '../model/destination_back_model.dart';

enum CreateDestinationsScreenState {
  intializing,
  loading,
  loaded,
  failed,
  created
}

class CreateDestinationsViewModel extends ChangeNotifier {
  CreateDestinationsScreenState state =
      CreateDestinationsScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  String errorMessage = "";
  bool destGoAdded = false;
  bool destOffAdded = false;

  final _client = http.Client();
  TextEditingController destGoTextController = TextEditingController();
  TextEditingController destOffTextController = TextEditingController();
  late int travelId;
  bool showBackDest = false;
  List<String> destsGoListString = [];
  List<String> destsOffListString = [];
  bool postGoFlag = false;
  DestinationGoModel? resultGo;
  DestinationBackModel? resultOff;
  // int? destGoID;
  // int? destOffID;
  List<dynamic>? destGoList;
  List<dynamic>? destBackList;

  // CreateDestinationsViewModel() {
  //   travelId=id;
  //   getAllDestGo();
  //   assign();
  // }
  addDestGo() async {
    if (destGoTextController.text == null ||
        destGoTextController.text == "" ||
        destGoTextController.text == " " ||
        destGoTextController.text == "  " ||
        destGoTextController.text == "   ") {
      return;
    }
    if (await postDestinationGo(destGoTextController.text)) {
      destsGoListString.add(destGoTextController.text);
      destGoTextController.clear();
      notifyListeners();
    }
    // destGoID = resultGo!.destinationGoID;
    notifyListeners();
  }
deleteTravel(int id){

   Dio dio=Dio();
var params={
  'id':id
};
try{
var response=dio.delete('$baseUrl/api/Travels',queryParameters: params);
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on DioError catch (e) {
      _handleDioErrors(e);
      return false;
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateDestinationsScreenState.failed);
      return false;
    }


}
  addDestOff() async{
    if (destOffTextController.text == null ||
        destOffTextController.text == "") {
      return;
    } else {
      if (await postDestinationOff(destOffTextController.text)) {
        destsOffListString.add(destOffTextController.text);
        destOffTextController.clear();
      }
      // destOffID = resultOff!.destinationBackId;
      notifyListeners();
    }
  }

  deleteDestGo(int index) {
    destsGoListString.removeAt(index);

    notifyListeners();
  }

  deleteDestOff(int index) {
    destsOffListString.removeAt(index);
    notifyListeners();
  }

  checkSwitchBool(bool val) {
    showBackDest = val;
    notifyListeners();
  }

  Future<bool> postDestinationGo(String destName) async {
    var params = {'TravelID': travelId, 'DestinationName': destName};
    final Dio dio = Dio();
    try {
      var response = await dio.post("$baseUrl/api/DestinationGoes",
          queryParameters: params);
      var stringObject = Map<String, dynamic>.from(response.data);
      resultGo = DestinationGoModel.fromJson(stringObject);

      if (response.statusCode == 201) {
        errorMessage = "Destination created";
        destGoAdded = true;
        setState(CreateDestinationsScreenState.created);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on DioError catch (e) {
      _handleDioErrors(e);
      return false;
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateDestinationsScreenState.failed);
      return false;
    }
  }

  Future<bool> postDestinationOff(String destName) async {
    var params = {
      'DestinationName': destName,
      'TravelID': travelId,
    };
    final Dio dio = Dio();
    try {
      var response = await dio.post("$baseUrl/api/DestinationBacks",
          queryParameters: params);
      var stringObject = Map<String, dynamic>.from(response.data);
      resultOff = DestinationBackModel.fromJson(stringObject);

      if (response.statusCode == 201) {
        errorMessage = "Destination created";
        destOffAdded = true;
        setState(CreateDestinationsScreenState.created);
notifyListeners();
        return true;
      } else {
        return false;
      }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateDestinationsScreenState.failed);
      return false;
    } on DioError catch (e) {
      _handleDioErrors(e);
      return false;
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateDestinationsScreenState.failed);
      return false;
    }

    // if(response.statusCode==200){

    // }
  }
    Future<List<dynamic>> fetchDestBack() async {
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

  Future<List<dynamic>> fetchDestGo() async {
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

  getDestGo() async {
      destGoList = await fetchDestGo();
      return destGoList;
  }

  getDestBack() async {
      destBackList = await fetchDestBack();
      return destBackList;
  }

  

  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(CreateDestinationsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(CreateDestinationsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(CreateDestinationsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(CreateDestinationsScreenState.failed);
            errorMessage = "User not found, :404 ";
            break;
          case 400:
            setState(CreateDestinationsScreenState.failed);
            errorMessage = "PLease insert a proper name ";
            break;
          case 500:
            setState(CreateDestinationsScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(CreateDestinationsScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(CreateDestinationsScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
