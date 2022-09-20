import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/model/destination_back_model.dart';
import 'package:bus/model/destination_go_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum CreateTimesScreenState {
  intializing,
  loading,
  loaded,
  failed,
  created
}

class CreateTimesViewModel extends ChangeNotifier {
    CreateTimesScreenState state =
      CreateTimesScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }
  String errorMessage="";

  int? travelId;
  List<dynamic> destGoList =[];
  List<dynamic> destBackList=[] ;
  TimeOfDay? time;
  String? mTime;

  String? date;

  DateTime? timeDate;
  List<String> timesList = [];


deleteTravel(int id){

   Dio dio=Dio();
var params={
  'id':id
};
try{
var response=dio.delete('$baseUrl/api/Travels',queryParameters: params);
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(CreateTimesScreenState.failed);
      return false;
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateTimesScreenState.failed);
      return false;
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateTimesScreenState.failed);
      return false;
    } on DioError catch (e) {
      _handleDioErrors(e);
      return false;
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateTimesScreenState.failed);
      return false;
    }


}


  Future<List<dynamic>> fetchDestBack() async {
    // notifyListeners();
    var params = {
      'TravelID': travelId,
    };
    final Dio dio = Dio();
    try{
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
         on SocketException{
                errorMessage = "PLease check your connection";
      setState(CreateTimesScreenState.failed);
      return [];

         }
          on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateTimesScreenState.failed);
            return [];

    } on TimeoutException{
            errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateTimesScreenState.failed);
            return [];


    }
     on DioError catch (e) {
      _handleDioErrors(e);
            return [];

    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateTimesScreenState.failed);
            return [];

    }

  }

getDestGo()async{
  if(destGoList.isEmpty){
    destGoList=await fetchDestGo();
  return destGoList;
  } else{
    return destGoList;

  }
}

getDestBack()async{
  if(destBackList.isEmpty){
    destBackList=await fetchDestBack();
  } else{
    return destBackList;

  }
  return destBackList;
}


  Future<List<dynamic>> fetchDestGo() async {
    // notifyListeners();
    var params = {
      'TravelID': travelId,
    };
    final Dio dio = Dio();
    try{
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
         on SocketException{
                errorMessage = "PLease check your connection";
      setState(CreateTimesScreenState.failed);
      return [];

         }
          on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateTimesScreenState.failed);
            return [];

    } on TimeoutException{
            errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateTimesScreenState.failed);
            return [];


    }
     on DioError catch (e) {
      _handleDioErrors(e);
            return [];

    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateTimesScreenState.failed);
            return [];

    }


  }

//  Future<List<dynamic>> getAllDestGo()async{
//   final destinationsGo = await fetchAllDestGo();
//   return destinationsGo.map((e) => DestinationGoModel.fromJson(e)).toList();

//  }
  deleteDestback(int? id) async {
    var params = {
      'id': id,
    };
    final Dio dio = Dio();
    var response = await dio.delete("$baseUrl/api/DestinationBacks",
        queryParameters: params);
    response.statusCode;
    notifyListeners();
  }

  // deleteDestGo(int? id) async {
  //   var params = {
  //     'id': id,
  //   };
  //   final Dio dio = Dio();
  //   var response = await dio.delete("$baseUrl/api/DestinationGoes",
  //       queryParameters: params);
  //   response.statusCode;
  //   notifyListeners();
  // }

  // assign(int id) async {
  //   destBackList = await fetchDestBack(id);
  //   destGoList = await fetchDestGo(id);
  //   notifyListeners();
  // }

  Future timePickerGO(BuildContext context,int id) async {
    final initialTime = TimeOfDay.now();
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    time = newTime;
    String hours = time!.hour.toString().padLeft(2, '0');
    String minutes = time!.minute.toString().padLeft(2, '0');
    mTime = "$hours:$minutes:00";
    var params = {'DestinationGoID': id, 'Time': "${date}T${mTime}"};
    final Dio dio = Dio();
 try{
    var response =
        await dio.post("$baseUrl/api/TimeGoes", queryParameters: params);
    response.statusCode;
    if(response.statusCode==200 ||response.statusCode==201){
      errorMessage ="Time created";
      setState(CreateTimesScreenState.created);
    }
 }
     
         on SocketException{
                errorMessage = "PLease check your connection";
      setState(CreateTimesScreenState.failed);

         }
          on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateTimesScreenState.failed);
    } on TimeoutException{
            errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateTimesScreenState.failed);

    }
     on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateTimesScreenState.failed);
    }

    notifyListeners();
  }

  Future timePickerBack(BuildContext context,int id) async {
    final initialTime = TimeOfDay.now();
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    time = newTime;
    String hours = time!.hour.toString().padLeft(2, '0');
    String minutes = time!.minute.toString().padLeft(2, '0');
    mTime = "$hours:$minutes:00";
    var params = {'DestinationBackID': id, 'Time': "${date}T${mTime}"};
    final Dio dio = Dio();
 try{   var response =
        await dio.post("$baseUrl/api/TimeBacks", queryParameters: params);
    response.statusCode;
        if(response.statusCode==200 ||response.statusCode==201){
      errorMessage ="Time created";
      setState(CreateTimesScreenState.created);
    }

 }
     
         on SocketException{
                errorMessage = "PLease check your connection";
      setState(CreateTimesScreenState.failed);

         }
          on FormatException {
      errorMessage = "Error happened try agian later";
      setState(CreateTimesScreenState.failed);
    } on TimeoutException{
            errorMessage = "Your internet connection is bad please try agian later";
      setState(CreateTimesScreenState.failed);

    }
     on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(CreateTimesScreenState.failed);
    }

    notifyListeners();
  }

  Future datePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().day + 1),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (newDate == null) return;
    timeDate = newDate;
    String years = newDate.year.toString().padLeft(2, '0');
    String months = newDate.month.toString().padLeft(2, '0');
    String days = newDate.day.toString().padLeft(2, '0');
    date = "$years-$months-$days";

    notifyListeners();
  }

    _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(CreateTimesScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(CreateTimesScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(CreateTimesScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(CreateTimesScreenState.failed);
            errorMessage = "User not found, :404 ";
            break;
          case 400:
            setState(CreateTimesScreenState.failed);
            errorMessage = "Select a date first ";
            break;
          case 500:
            setState(CreateTimesScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(CreateTimesScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(CreateTimesScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }

}
