import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/model/traveler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/travelers_model.dart';
import '../model/travels_model.dart';
enum TravelerScreenState { intializing, loading, loaded, failed, notConnected }


class TravelerViewModel extends ChangeNotifier{
  List<dynamic>? travels;
// List<dynamic>? destinations;
List<dynamic>? travelers;
  TravelerScreenState state = TravelerScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }
bool? connected;
  String errorMessage = "";

deleteTraveler(int id)async{
  Dio dio=Dio();
final params={
'id':id
};
try{
final response = await dio.delete('$baseUrl/api/Travelers',queryParameters: params);

if(response.statusCode==200){
notifyListeners();
}

}
 on SocketException{
            errorMessage = "Not connected";
      setState(TravelerScreenState.notConnected);

    }
     on FormatException {
      errorMessage = "Error occured try agian later";
      setState(TravelerScreenState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    }

}

// Future<List<dynamic>>? 
fetchTravelers(int id)async{
    List<dynamic>? travelers;

Dio dio=Dio();
var params={
'TravelID':id
};
try{
var response=await dio.get('$baseUrl/api/Travelers/GetTravelersByDestination',queryParameters: params);
if(response.statusCode==200){
        final data = await response.data;
        //         var stringObject = Map<String, dynamic>.from(response.data);
        // travelers = TravelersModel.fromJson(stringObject);

// travelers=data.map((e) => travelerFromJson(e).toList());
//         //  return data.map((e) => Traveler.fromJson(e)).toList();
//                 var data = await response.data;

        travelers = data.map((e) => TravelersModel.fromJson(e)).toList();
return travelers ;

}else{
  // return [];
}


}   
 on SocketException{
            errorMessage = "Not connected";
      setState(TravelerScreenState.notConnected);
      return [];

    }
     on FormatException {
      errorMessage = "Error occured try agian later";
      setState(TravelerScreenState.failed);
      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      return [];
    }
if(travelers==null){
  return [];

}
else{
  travelers=travelers;
  return travelers;
}

}






// getTravelers()async{
//   travelers=await fetchTravelers();
//   notifyListeners();
// }
  Future<List<dynamic>> fetchAllTravles() async {
    final Dio dio = Dio();
    List<dynamic>? mTravels;
    try {
      var response = await dio.get(
        "$baseUrl/api/Travels",
      );

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var data = await response.data;

        mTravels= data.map((e) => TravelsModel.fromJson(e)).toList();
        //  (data as List).map((e) => DestinationGoModel.fromJson(e)).toList();

        // destinationBackModelFromJson(result);
        // return s;
      }
    } 
    on SocketException{
            errorMessage = "Not connected";
      setState(TravelerScreenState.notConnected);
      return [];

    }
     on FormatException {
      errorMessage = "Error occured try agian later";
      setState(TravelerScreenState.failed);
      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      return [];
    }
if(mTravels==null){
  return [];
}else{
  travels=mTravels;
  return mTravels;
}
  }

  // getTravels() async {
  //   travels = await fetchAllTravles();
  //   notifyListeners();
  // }


  // getImage(){

getTravels()async{
  if(travels==null){
    travels=await fetchAllTravles();
    return travels;
  }else{
    return travels;
  }
}
getTravelers(int id)async{
    travelers=await fetchTravelers(id);
    return travelers;
//   }else if(travelers!.isEmpty){
// return;
//   }
}
  // }
  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(TravelerScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(TravelerScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(TravelerScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(TravelerScreenState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(TravelerScreenState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(TravelerScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(TravelerScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(TravelerScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }


}