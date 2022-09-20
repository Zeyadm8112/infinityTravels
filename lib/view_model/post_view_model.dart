import 'dart:async';
import 'dart:io';

import 'package:bus/consts/constants.dart';
import 'package:bus/model/posts_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


enum PostsState{intializing,loading,loaded,failed}
class PostsViewModel extends ChangeNotifier{
PostsState state = PostsState.intializing;
String errorMessage="";
setState(PostsState state){
this.state=state;
notifyListeners();
}
   
List<dynamic>? posts;

fetchPosts()async{
  List<dynamic>? posts;

  Dio dio=Dio();

try{
var response=await  dio.get('$baseUrl//api/TimeLines');
      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var data = await response.data;

   posts=      data.map((e) => Posts.fromJson(e)).toList();

      // notifyListeners();
        //  (data as List).map((e) => DestinationGoModel.fromJson(e)).toList();
return posts;
        // destinationBackModelFromJson(result);
        // return s;
      }

}on SocketException {
      errorMessage = "PLease check your connection";
      setState(PostsState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(PostsState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(PostsState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e) {
      errorMessage = "Error happened try agian later";
      setState(PostsState.failed);
    }

}


getPosts()async{
  posts=await fetchPosts();
return posts;
}





  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(PostsState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(PostsState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(PostsState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(PostsState.failed);
            errorMessage = "User not found, :404 ";
            break;
          case 400:
            setState(PostsState.failed);
            errorMessage = "You can't make two travels with one photo ";
            break;
          case 500:
            setState(PostsState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(PostsState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(PostsState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }


  
}