import 'dart:async';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:login_demo/model/services/token_service.dart';

// import '../model/model/token_model.dart';
import '../model/token_model.dart';

enum RegisterManagerScreenState { intializing, loading, successfull, failed }

class RegisterManagerViewModel extends ChangeNotifier {
  RegisterManagerScreenState state = RegisterManagerScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  String errorMessage = "";

  Future registerUser(String name, String number, String email,
      String password, String confirmPassword, BuildContext context) async {

    Token result;
    // List<Token> tokenList = [];
    var params = {'Rolename': 'Admin', 'TargetRole': 'Manger'};
    var formMap = {
      'UserName': name,
      'PhoneNumber': number,
      'Email': email,
      'Password': password,
      'ConfirmPassword': confirmPassword
    };
    final dio = Dio();
    try {
      setState(RegisterManagerScreenState.loading);
      final response = await dio.post(
          "$baseUrl/api/Account/Register",
          data: formMap,
          queryParameters: params,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode == 200) {
        errorMessage="Manager created";
              setState(RegisterManagerScreenState.successfull);

Navigator.pop(context);
        return true;
      }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(RegisterManagerScreenState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(RegisterManagerScreenState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(RegisterManagerScreenState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    }
  }

  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(RegisterManagerScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(RegisterManagerScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(RegisterManagerScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(RegisterManagerScreenState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(RegisterManagerScreenState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(RegisterManagerScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(RegisterManagerScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(RegisterManagerScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
