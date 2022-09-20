import 'dart:async';
import 'dart:io';

import 'package:bus/consts/values.dart';
import 'package:bus/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:login_demo/model/services/token_service.dart';

// import '../model/model/token_model.dart';
import '../consts/constants.dart';
import '../model/token_model.dart';

enum ScreenState { intializing, loading, loaded, failed }

class TokenViewModel extends ChangeNotifier {
  ScreenState state = ScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  String errorMessage = "";
  Future<Token?> fetchTokens(
      String name, String password, BuildContext context) async {
    Token result;
    // List<Token> tokenList = [];

    var formMap = {
      'grant_type': 'password',
      'username': name,
      'password': password
    };
    final dio = Dio();
    try {
      setState(ScreenState.loading);
      final response = await dio.post(
          "$baseUrl/token",
          data: formMap,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode == 200) {
        var stringObject = Map<String, dynamic>.from(response.data);
        result = Token.fromJson(stringObject);

        if (result.roleName == "User") {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/MainScreenUser');
          setState(ScreenState.loaded);
        } else if (result.roleName == "Manger") {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/MainScreen');
          setState(ScreenState.loaded);
        }else if (result.roleName == "Admin") {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/AdminDashBoardScreen');
          setState(ScreenState.loaded);
        }
        if (result.roleName != null) {
          sharedPref!.setString("roleName", result.roleName.toString());
        }
        if (result.userID != null) {
          sharedPref!.setString("userID", result.userID.toString());
        }

        roleName = result.roleName.toString();

        return result;
      }
      // else if (response.statusCode == 404) {
      //   setState(ScreenState.failed);
      //   errorMessage = "User not found, ";
      // }
      // else if (response.statusCode == 400) {
      //   setState(ScreenState.failed);
      //   errorMessage = "Your username or password is wrong";
      // }
      // else if (response.statusCode == 408) {
      //   setState(ScreenState.failed);
      //   errorMessage =
      //       "Your internet connection is bad please try agian later,408";
      // }
      // else if (response.statusCode == 500) {
      //   setState(ScreenState.failed);
      //   errorMessage = "Something went wrong please try agian later, 408";
      // }
      // else {
      //   setState(ScreenState.failed);
      //   errorMessage = "Something went wrong please try agian later, else";
      // }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(ScreenState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(ScreenState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(ScreenState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    }
  }

  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(ScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(ScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(ScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(ScreenState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(ScreenState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(ScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(ScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(ScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
