import 'dart:async';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/model/travels_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/destination_go_model.dart';

enum AllTripsScreenState { intializing, loading, loaded, failed, notConnected }

class ViewAllTravelViewModel extends ChangeNotifier {
  List<dynamic>? travels;
    List<dynamic>? dests;
String? time;
  AllTripsScreenState state = AllTripsScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  bool? connected;
  String errorMessage = "";
  checkConnection() async {
    connected = await InternetConnectionChecker().hasConnection;
    connected!
        ? setState(AllTripsScreenState.intializing)
        : setState(AllTripsScreenState.notConnected);
  }
    Future<List<dynamic>> fetchDestGo(int id) async {
    var params = {
      'TravelID': id,
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
  deleteTravel(int id)async{

   Dio dio=Dio();
var params={
  'id':id
};
try{
var response=await dio.delete('$baseUrl/api/Travels',queryParameters: params);
response.statusCode;
if(response.statusCode==200){
  
}
print(response.statusCode);
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(AllTripsScreenState.failed);
      return false;
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(AllTripsScreenState.failed);
      return false;
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(AllTripsScreenState.failed);
      return false;
    } on DioError catch (e) {
      _handleDioErrors(e);
      return false;
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(AllTripsScreenState.failed);
      return false;
    }


}

getDestiantions(int id)async{
    if (dests == null) {
     return dests = await fetchDestGo(id);
    } else {
      return dests;
    }
}
fetchTime(String id)async{
  Dio dio =Dio();
  var params={
'TravelID':id
  };
var response = await dio.get('$baseUrl/api/Travels/GetTravelsDate',queryParameters: params);

return response.data.toString();
}

getTime(String id)async{
  time = await fetchTime(id);
  return time;

}



  Future<List<dynamic>?> fetchAllTravles() async {
    final Dio dio = Dio();
    List<dynamic>? mTravels;
    try {
      var response = await dio.get(
        "$baseUrl/api/Travels",
      );

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var data = await response.data;

        return  data.map((e) => TravelsModel.fromJson(e)).toList();
         
      // notifyListeners();
        //  (data as List).map((e) => DestinationGoModel.fromJson(e)).toList();

        // destinationBackModelFromJson(result);
        // return s;
      }
    } on SocketException {
      errorMessage = "Not connected";
      setState(AllTripsScreenState.notConnected);
      // notifyListeners();

      return [];
    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(AllTripsScreenState.failed);
      // notifyListeners();

      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      // notifyListeners();

      return [];
    }
    // if (mTravels == null) {
    //   return [];
    // } else {
    //   travels = mTravels;
    //   return mTravels;
    // }
  }

  // getTravels() async {
  //   travels = await fetchAllTravles();
  //   notifyListeners();
  // }

  // getImage(){

  getTravels() async {
      travels = await fetchAllTravles();
        return travels;
  }

  // }
  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(AllTripsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(AllTripsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(AllTripsScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(AllTripsScreenState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(AllTripsScreenState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(AllTripsScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(AllTripsScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(AllTripsScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
