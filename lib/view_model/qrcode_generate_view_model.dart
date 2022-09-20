import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:bus/view/screens/user/qrcode_generate_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class QrcodeGenerateViewModel extends ChangeNotifier{
String? userSubscription;
  Future<String?> fetchQrcode() async {
    String? userSubscription;

Dio dio=Dio();
var params={
  'UserID':sharedPref!.getString('userID')
};
try{
var response =await dio.get('$baseUrl//api/Users/UserSubscription',queryParameters: params);
if(response.statusCode==200){
userSubscription=response.data.toString();
return userSubscription;
}else{
  print(response.data);
}
}
catch(e){
  rethrow;

}

  }

  getQrCode()async{
    if(userSubscription==null){
      userSubscription=await fetchQrcode();
    }else{
      return userSubscription;
    }
      return userSubscription;

  }
}