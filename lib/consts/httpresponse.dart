class HTTPResponse<T>{
  bool isSucessful =false;
  T? data;
  String? message;
  int? responseCode;
  HTTPResponse(this.isSucessful,this.data,{ required this.message,required this.responseCode});
}