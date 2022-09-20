import 'dart:async';
import 'dart:io';

import 'package:bus/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../consts/constants.dart';
enum PostScreenState {intializing, loading, loaded, failed,success }

class CreatePostViewModel extends ChangeNotifier{








  PostScreenState state = PostScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  String errorMessage = "";



postMassege(String header,String body,BuildContext context)async{

  var params={
    'UserID':sharedPref!.getString('userID'),
    'Header':header,
    'Text':body
  };
   Dio dio=Dio();
    try {
      setState(PostScreenState.loading);
      final response = await dio.post(
          "$baseUrl/api/TimeLines",
          queryParameters: params,);
      if (response.statusCode == 201) {
errorMessage="Post created";
              setState(PostScreenState.success);

Navigator.pop(context);
      }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(PostScreenState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(PostScreenState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(PostScreenState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    }


}







    // try {
    //   setState(PostScreenState.loading);
    //   final response = await dio.post(
    //       "$baseUrl/api/Account/Register",
    //       data: formMap,
    //       queryParameters: params,
    //       options: Options(contentType: Headers.formUrlEncodedContentType));
    //   if (response.statusCode == 200) {
    //           setState(PostScreenState.loaded);

    //     Navigator.pushNamed(context, '/MainScreenUser');

    //     return true;
    //   }
    // } on SocketException {
    //   errorMessage = "PLease check your connection";
    //   setState(PostScreenState.failed);
    // } on FormatException {
    //   errorMessage = "Error happened try agian later";
    //   setState(PostScreenState.failed);
    // } on TimeoutException {
    //   errorMessage = "Your internet connection is bad please try agian later";
    //   setState(PostScreenState.failed);
    // } on DioError catch (e) {
    //   _handleDioErrors(e);
    // }





  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(PostScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later";
        break;
      case DioErrorType.sendTimeout:
        setState(PostScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later";
        break;
      case DioErrorType.receiveTimeout:
        setState(PostScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(PostScreenState.failed);
            errorMessage = "Something went wrong please try agian later";
            break;
          case 400:
            setState(PostScreenState.failed);
            errorMessage = "Something went wrong please try agian later";
            break;
          case 500:
            setState(PostScreenState.failed);
            errorMessage = "Something went wrong please try agian later";
            break;
          case 408:
            setState(PostScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(PostScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }




}