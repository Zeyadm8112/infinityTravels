import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/model/travels_model.dart';
import 'package:bus/view/screens/manager/manager_travel_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

enum ManagerTripsScreenState {
  intializing,
  loading,
  loaded,
  failed,
  notConnected
}

class ManagerTravelsViewModel extends ChangeNotifier {
  List<dynamic>? travels;
  ManagerTripsScreenState state = ManagerTripsScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  bool? connected;
  String errorMessage = "";

  Future<List<dynamic>> fetchAllTravles() async {
    final Dio dio = Dio();
    List<dynamic>? mTravels; 
    var params={
'userId':sharedPref!.getString('userID').toString()
    };
    try {
      var response = await dio.get(
        "$baseUrl/api/Travels",
        queryParameters: params
      );

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var data = await response.data;

        mTravels = data.map((e) => TravelsModel.fromJson(e)).toList();
        //  (data as List).map((e) => DestinationGoModel.fromJson(e)).toList();

        // destinationBackModelFromJson(result);
        // return s;
      }
    } on SocketException {
      errorMessage = "Not connected";
      setState(ManagerTripsScreenState.notConnected);
      return [];
    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(ManagerTripsScreenState.failed);
      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      return [];
    }
    if (mTravels == null) {
      return [];
    } else {
      travels = mTravels;
      return mTravels;
    }
  }

  // getTravels() async {
  //   travels = await fetchAllTravles();
  //   notifyListeners();
  // }

  // getImage(){

  getTravels() async {
    if (travels == null) {
      travels = await fetchAllTravles();
      return travels;
    } else {
      return travels;
    }
  }

  // }
  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(ManagerTripsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(ManagerTripsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(ManagerTripsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(ManagerTripsScreenState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(ManagerTripsScreenState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(ManagerTripsScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(ManagerTripsScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(ManagerTripsScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
