import 'package:bus/consts/constants.dart';
import 'package:bus/view_model/token_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
enum ScanState{intial,found,notFound,unknown}
class QrcodeScannerViewModel extends ChangeNotifier{
ScanState state=ScanState.intial;
// late String travelId;
// late String goBool;

setState(ScanState state){
  this.state=state;
  notifyListeners();
}

String? result;
// checkUser(String result){
// if(result=='false'|| result=='False'){
//   setState(ScanState.notFound);
// }else if(result=='true'|| result=='True'){
//   setState(ScanState.found);
// }else{
//   setState(ScanState.unknown);

// }



checkTraveler(String userId,String traverId,String Go)async{
  Dio dio =Dio();
  var params={
  'UserID'  :userId,
  'TravelID':traverId,
  'Go':Go
  };
var response=await dio.get('$baseUrl/api/QRCodeSystem/ExisitUserTravel',queryParameters: params);
verfiyCode(response.data.toString());
// return  response.data.toString();

}
 verfiyCode(String result){
  if(result=="true"){
    setState(ScanState.found);
  }else
if(result=='false'){
    setState(ScanState.notFound);

}else{
  setState(ScanState.unknown);
}
   
 }



}






