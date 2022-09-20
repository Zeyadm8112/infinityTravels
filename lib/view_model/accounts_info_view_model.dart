import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/Account.dart';

enum ManagersInfoScreenState {
  intializing,
  loading,
  loaded,
  failed,
  notConnected
}

class AccountsInfoViewModel extends ChangeNotifier {
  int? allUsersNumber;
  int? usersNumber;
  int? managersNumber;
  int? adminsNumber;
  double? usersPercent;
  double? managersPercent;
  double? adminsPercent;
  List<dynamic>? users;
  List<dynamic>? managers;
  List<dynamic>? admins;
  ManagersInfoScreenState state = ManagersInfoScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  String errorMessage = "";

  Future<List<dynamic>> fetchUsers() async {
    Dio dio = Dio();
    var params = {'RoleName': 'User'};
    List<dynamic>? users;
    try {
      var response = await dio.get('$baseUrl/api/Users/GetAccUsers',
          queryParameters: params);
      if (response.statusCode == 200) {
        var data = await response.data;

        users = data.map((e) => Account.fromJson(e)).toList();
      } else {
        return [];
      }
    } on SocketException {
      errorMessage = "No internet connection";
      setState(ManagersInfoScreenState.failed);
    } on FormatException {
      errorMessage = "Something went wrong trye agian later";
      setState(ManagersInfoScreenState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    }
    if (users == null) {
      return [];
    } else {
      return users;
    }
  }

  getUsers() async {
    if(users==null){
    users = await fetchUsers();
    }else{
      return users;
    }
    notifyListeners();
  }

  Future<List<dynamic>?> fetchMangers() async {
    Dio dio = Dio();
    var params = {'RoleName': 'Manger'};
    List<dynamic>? managers;
    try {
      var response = await dio.get('$baseUrl/api/Users/GetAccUsers',
          queryParameters: params);
      if (response.statusCode == 200) {
        var data = await response.data;

        managers = data.map((e) => Account.fromJson(e)).toList();
        return managers;
      } else {
        return [];
      }
    }
     on SocketException {
      errorMessage = "No internet connection";
      setState(ManagersInfoScreenState.failed);
    } on FormatException {
      errorMessage = "Something went wrong trye agian later";
      setState(ManagersInfoScreenState.failed);
    } on DioError catch (e) {
_handleDioErrors(e);
    }
    if (managers == null) {
      return [];
    } else {
      // this. managers=managers;
      return managers;
    }
  }

  getManagers() async {
    if (managers == null) {
      managers = await fetchMangers();

      return managers;
    } else {

      return managers;
    }
  }

  Future<List<dynamic>> fetchAdmins() async {
    Dio dio = Dio();
    var params = {'RoleName': 'Admin'};
    List<dynamic>? admins;
    try {
      var response = await dio.get('$baseUrl/api/Users/GetAccUsers',
          queryParameters: params);
      if (response.statusCode == 200) {
        var data = await response.data;

        admins= data.map((e) => Account.fromJson(e)).toList();
      } else {
        return [];
      }
    }      on SocketException {
      errorMessage = "No internet connection";
      setState(ManagersInfoScreenState.failed);
    } on FormatException {
      errorMessage = "Something went wrong try agian later";
      setState(ManagersInfoScreenState.failed);
    } on DioError catch (e) {
_handleDioErrors(e);
    }
    if (admins == null) {
      return [];
    } else {
      // this. managers=managers;
      return admins;
    }

    }
  

  getAdmins() async {
    if(admins==null){
  return admins=await fetchAdmins();
    }
else{
  return admins;
}  }

  Future fetchAllUsersNumber() async {
    int num;
    Dio dio = Dio();
    try {
      var response = await dio.get('$baseUrl//api/Users/GetAllUsers');
      if (response.statusCode == 200) {
        num = response.data;
        return num;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future fetchUsersNumber() async {
    int num;
    Dio dio = Dio();
    try {
      var response = await dio.get('$baseUrl//api/Users/GetNoUsers');
      if (response.statusCode == 200) {
        num = response.data;
        return num;
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  getUsersNumber() async {
    usersNumber = await fetchUsersNumber();
    notifyListeners();
  }

  getManagersNumber() async {
    managersNumber = await fetchManagersNumber();
    notifyListeners();
  }

  getAdminsNumber() async {
    adminsNumber = await fetchAdminsNumber();
    notifyListeners();
  }

  Future fetchManagersNumber() async {
    int num;
    Dio dio = Dio();
    try {
      var response = await dio.get('$baseUrl//api/Users/GetNoManger');
      if (response.statusCode == 200) {
        num = response.data;
        return num;
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future fetchAdminsNumber() async {
    int num;
    Dio dio = Dio();
    try {
      var response = await dio.get('$baseUrl//api/Users/GetNoAdmin');
      if (response.statusCode == 200) {
        num = response.data;
        return num;
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  getAccountsDetails() async {
  
    allUsersNumber = await fetchAllUsersNumber();
    usersNumber = await fetchUsersNumber();
    managersNumber = await fetchManagersNumber();
    adminsNumber = await fetchAdminsNumber();
    usersPercent = (usersNumber! / allUsersNumber!) * 100;
    adminsPercent = (adminsNumber! / allUsersNumber!) * 100;
 usersPercent=double.parse(usersPercent!.toStringAsFixed(2));

 adminsPercent=double.parse(adminsPercent!.toStringAsFixed(2));
    managersPercent = (managersNumber! / allUsersNumber!) * 100;
  return  managersPercent=double.parse(managersPercent!.toStringAsFixed(2));


}
  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(ManagersInfoScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(ManagersInfoScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(ManagersInfoScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(ManagersInfoScreenState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(ManagersInfoScreenState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(ManagersInfoScreenState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(ManagersInfoScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(ManagersInfoScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }

}