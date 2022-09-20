import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:bus/model/destination_back_model.dart';
import 'package:bus/model/destination_go_model.dart';
import 'package:bus/model/time_back.dart';
import 'package:bus/model/time_go.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/create_travels_model.dart';
import '../model/travel_model.dart';
import '../model/travels_model.dart';
import '../repo/travel_repositry.dart';

enum EditState { intial, loading, deleted, sucess, failed }

class EditTravelViewModel extends ChangeNotifier {
  String errorMessage = "";
  EditState state = EditState.intial;
  setState(EditState state) {
    this.state = state;
    notifyListeners();
  }

  // int travelId = sharedPref!.getInt('travelId')!;
  // File? img;
  Travel? travel;
  TextEditingController travelNameController = TextEditingController();
  TextEditingController travelDescController = TextEditingController();
  TextEditingController travelAppointController = TextEditingController();
  TextEditingController numberOfSiteController = TextEditingController();


  bool nameEdited = false;
  bool imageEdited = false;
  bool descEdited = false;
  bool appointEdited = false;
  bool sitesEdited = false;
  bool loading = false;
  List<dynamic>? timeGo;
  List<dynamic>? timeBack;
  String? time;
  TimeOfDay? timeDay;
  String? mTime;

  String? date;

  DateTime? timeDate;

  bool error = false;
  File? img;
  // PickedFile? pickedImage;

  List<dynamic> destGoList = [];
  List<dynamic> destBackList = [];

  getTravel(int id) async {
   return travel = await fetchTravel(id);
  }

  int _noOfSites = 50;
  Future<Travel> fetchTravel(int id) async {
    Travel result;
    var params = {'id': id};
    final Dio dio = Dio();
    var response = await dio.get("$baseUrl/api/Travels/GetTravelByid",
        queryParameters: params);
    var stringObject = Map<String, dynamic>.from(response.data);
    //  var s=  DestinationGoModel.fromJson(stringObject);
    // var data = response.data;
    // var stringObject = Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200) {
      return Travel.fromJson(stringObject);
      ;
    } else {
      print('${response.statusCode} : ${response.data.toString()}');
      throw "error";
    }
  }

  pickNumber(int val) {
    travel!.noOfSites = val;
    notifyListeners();
  }

  late FormData formMap;
  String? fileName;

  String? filePath;
// File Set image=>_img
  Future pickImage(ImageSource src) async {
//     final image = await ImagePicker().pickImage(source: src);
//     if (image==null) return ;
//      var duplicateFilePath = await getApplicationDocumentsDirectory();
//       var fileName= basename(image.path);
//       //  File localImage=
//         image.saveTo('$duplicateFilePath.path/$fileName');
// File localImage= duplicateFilePath.path;

    var random = Random.secure();

// var value = random.nextInt(1000000000);

//       img = image ;
    // 1. Create an ImagePicker instance.
    final ImagePicker _picker = ImagePicker();

    // 2. Use the new method.
    //
    String fileName = basename(
        "${random.nextInt(1000000000).toString()}-${random.nextInt(1000000000).toString()}-${random.nextInt(1000000000).toString()}-${random.nextInt(1000000000).toString()}"); // Filename without extension

    // getImage now returns a PickedFile instead of a File (form dart:io)
    final PickedFile? pickedImage = await _picker.getImage(source: src);

    // 3. Check if an image has been picked or take with the camera.
    if (pickedImage == null) {
      return;
    }

    // 4. Create a File from PickedFile so you can save the file locally
    // This is a new/additional step.
    File tmpFile =await File(pickedImage.path).create(recursive: true);

    // 5. Get the path to the apps directory so we can save the file to it.
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String path = appDocumentsDirectory.path;

    final String fileExtension = extension(pickedImage.path); // e.g. '.jpg'

    // 6. Save the file by copying it to the new location on the device.
    // if (tmpFile.existsSync()) {
    //   fileName = "$fileName$fileExtension";
    //   this.fileName = fileName;
    //   // 7. Optionally, if you want to display the taken picture we need to update the state
    //   // Note: Copying and awaiting the file needs to be done outside the setState function.
    //   img = tmpFile;
    // } else {
      tmpFile = await tmpFile.copy('$path/$fileName');
      fileName = "$fileName$fileExtension";
      this.fileName = fileName;
      // 7. Optionally, if you want to display the taken picture we need to update the state
      // Note: Copying and awaiting the file needs to be done outside the setState function.
      img = tmpFile;
    // }
    notifyListeners();
  }

  Future editTravel(BuildContext context, int id) async {
    // loading = true;
    var params = {
      'id': id,
      'TravelName': nameEdited
          ? travelNameController.text.toString()
          : travel!.travelName.toString(),
      'UserCreatorID': sharedPref!.getString('userID').toString(),
      'NoOfSites':
          sitesEdited ? numberOfSiteController.text.toString() :  _noOfSites.toString(),
      'TravelDescription': descEdited
          ? travelDescController.text.toString()
          : travel!.travelDescription.toString(),
      'TravelAppointment': appointEdited
          ? travelAppointController.text.toString()
          : travel!.travelAppointment.toString(),
      'EditPhoto': imageEdited
    };
    var response;
    if (imageEdited) {
      var dio = Dio();
      FormData formData = FormData.fromMap({
        'SendFile': await MultipartFile.fromFile(img!.path, filename: fileName),
      });
      response = await dio.put("$baseUrl/api/Travels",
          data: formData, queryParameters: params);
    } else {
      var dio = Dio();
      response = await dio.put("$baseUrl/api/Travels", queryParameters: params);
    }
//   final Uri url=Uri.parse("http://icecode-001-site1.itempurl.com//api/Travels");
//  var bytes = img!.readAsBytesSync();

// http.MultipartRequest request = new http.MultipartRequest("POST", url);

    if (response.statusCode == 201) {
      // var stringObject = Map<String, dynamic>.from(response.data);
      // var result = CreateTravelModel.fromJson(stringObject);
      img!.delete();
      notifyListeners();
    } else {
      // loading = false;
      // error = true;
            notifyListeners();

    }

  }

  Future<List<dynamic>> fetchDestBack(int id) async {
    var params = {
      'TravelID': id,
    };
    final Dio dio = Dio();
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

  fetchTime(int id) async {
    Dio dio = Dio();
    var params = {'TravelID': id};
    var response = await dio.get('$baseUrl/api/Travels/GetTravelsDate',
        queryParameters: params);

    return response.data.toString();
  }

  getDate(int id) async {
    time = await fetchTime(id);
    return time;
  }

  Future<List<dynamic>> fetchDestGo(int id) async {
    var params = {
      'TravelID': id,
    };
    final Dio dio = Dio();
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

  getDestGo(int id) async {
    destGoList = await fetchDestGo(id);
    // notifyListeners();
    return destGoList;
  }

  getDestBack(int id) async {
    destBackList = await fetchDestBack(id);
    return destBackList;
  }

  Future<List<dynamic>?> fetchTimesGo(int destId) async {
    List<dynamic>? time;
    var params = {
      'DestinationGoID': destId,
    };

    try {
      Dio dio = Dio();
      var response =
          await dio.get("$baseUrl/api/TimeGoes", queryParameters: params);

      if (response.statusCode == 200) {
        var data = response.data;
        time = data.map((e) => TimeGo.fromJson(e)).toList();

        return time;
      } else {
        print('error');
        print(response.data);
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
    return time;
  }

  Future<List<dynamic>?> fetchTimesBack(int destId) async {
    List<dynamic>? time;
    var params = {
      'DestinationBackID': destId,
    };

    try {
      Dio dio = Dio();
      var response =
          await dio.get("$baseUrl/api/TimeBacks", queryParameters: params);

      if (response.statusCode == 200) {
        var data = response.data;
        time = data.map((e) => TimeBack.fromJson(e)).toList();

        return time;
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
    return time;
  }

  getTimeGo(int destId) async {
    timeGo = await fetchTimesGo(destId);
    notifyListeners();
  }

  getTimeBack(int destId) async {
    timeBack = await fetchTimesBack(destId);
    notifyListeners();
  }

  editDestGo(int id, String name) async {
    var params = {'id': id, 'DestinationName': name};
    var dio = Dio();
    try {
      var response = await dio.put("$baseUrl/api/DestinationGoes",
          queryParameters: params);
      if (response.statusCode == 200) {
        errorMessage = "Edited Sucessfully";
        setState(EditState.sucess);
      }
    } on SocketException {
      errorMessage = "Not connected";
      setState(EditState.failed);
      // notifyListeners();
    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(EditState.failed);
      // notifyListeners();

      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      // notifyListeners();

    }
  }

  editDestBack(int id, String name) async {
    var params = {'id': id, 'DestinationName': name};
    var dio = Dio();
        try {

    var response =
        await dio.put("$baseUrl/api/DestinationBacks", queryParameters: params);
              if (response.statusCode == 200) {
        errorMessage = "Edited Sucessfully";
        setState(EditState.sucess);
      }
    } on SocketException {
      errorMessage = "Not connected";
      setState(EditState.failed);
      // notifyListeners();
    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(EditState.failed);
      // notifyListeners();

      return [];
    } on DioError catch (e) {
      _handleDioErrors(e);
      // notifyListeners();

    }

  }

  editTimesGo(int id, String time) async {
    var params = {'id': id, 'Time': time};
    var dio = Dio();
    var response =
        await dio.put("$baseUrl/api/TimeGoes", queryParameters: params);
  
  }

  editTimesback(int id, String time) async {
    var params = {'id': id, 'Time': time};
    var dio = Dio();
    var response =
        await dio.put("$baseUrl/api/TimeBacks", queryParameters: params);
  }

  deleteTravel(int id) async {
    var params = {'id': id};
    var dio = Dio();
    var response =
        await dio.delete("$baseUrl/api/Travels", queryParameters: params);
  }

  deleteDestGo(int id) async {
    var params = {'id': id};
    var dio = Dio();
    try {
      var response = await dio.delete("$baseUrl/api/DestinationGoes",
          queryParameters: params);
    } on SocketException {
      errorMessage = "Not connected";
      setState(EditState.failed);
      // notifyListeners();

    } on FormatException {
      errorMessage = "Error occured try agian later";
      setState(EditState.failed);
      // notifyListeners();

    } on DioError catch (e) {
      _handleDioErrors(e);
      // notifyListeners();

    }
  }

  deleteDestBack(int id) async {
    var params = {'id': id};
    var dio = Dio();
    var response = await dio.delete("$baseUrl/api/DestinationBacks",
        queryParameters: params);
  }

  deleteTimesGo(int id) async {
    var params = {'id': id};
    var dio = Dio();
    var response =
        await dio.delete("$baseUrl/api/TimeGoes", queryParameters: params);
  }

  deleteTimesBack(int id) async {
    var params = {'id': id};
    var dio = Dio();
    var response =
        await dio.delete("$baseUrl/api/TimeBacks", queryParameters: params);
  }

  Stream<Travel> fetchStreamedTravel(
      int travelId, StreamController controller) async* {
    Travel result;
    var params = {'id': travelId};
    final Dio dio = Dio();
    var response = await dio.get("$baseUrl/api/Travels/GetTravelByid",
        queryParameters: params);
    var stringObject = Map<String, dynamic>.from(response.data);
    //  var s=  DestinationGoModel.fromJson(stringObject);
    // var data = response.data;
    // var stringObject = Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200) {
      result = Travel.fromJson(stringObject);
      yield result;
    } else {
      print('${response.statusCode} : ${response.data.toString()}');
      throw "error";
    }
  }

  // Stream<Travel> getStreamedTravel(int travelId)
  //   => Stream.periodic(Duration(seconds: 2))
  //       .asyncMap((event) => fetchTravel(travelId));
  getStreamedTravel(int travelId, StreamController controller) async {
    travel = await fetchTravel(travelId);
    // controller.sink.add(travel);
  }

  Future timePickerGO(BuildContext context, int id) async {
    final initialTime = TimeOfDay.now();
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    timeDay = newTime;
    String hours = timeDay!.hour.toString().padLeft(2, '0');
    String minutes = timeDay!.minute.toString().padLeft(2, '0');
    mTime = "$hours:$minutes:00";
    var params = {'DestinationGoID': id, 'Time': "${date}T${mTime}"};
    final Dio dio = Dio();
    try {
      var response =
          await dio.put("$baseUrl/api/TimeGoes", queryParameters: params);
      response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage = "Time Edited Sucessfully";
        setState(EditState.sucess);
      }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(EditState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(EditState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(EditState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(EditState.failed);
    }

    notifyListeners();
  }

  Future timePickerBack(BuildContext context, int id) async {
    final initialTime = TimeOfDay.now();
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    timeDay = newTime;
    String hours = timeDay!.hour.toString().padLeft(2, '0');
    String minutes = timeDay!.minute.toString().padLeft(2, '0');
    mTime = "$hours:$minutes:00";
    var params = {'DestinationBackID': id, 'Time': "${date}T${mTime}"};
    final Dio dio = Dio();
    try {
      var response =
          await dio.put("$baseUrl/api/TimeBacks", queryParameters: params);
      response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage = "Time Edited Sucessfully";
        setState(EditState.sucess);
      }
    } on SocketException {
      errorMessage = "PLease check your connection";
      setState(EditState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(EditState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(EditState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e) {
      errorMessage = "Please fill the data";
      setState(EditState.failed);
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
        setState(EditState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,408";
        break;
      case DioErrorType.sendTimeout:
        setState(EditState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,2";
        break;
      case DioErrorType.receiveTimeout:
        setState(EditState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later,3";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(EditState.failed);
            errorMessage = "User not found, ";
            break;
          case 400:
            setState(EditState.failed);
            errorMessage = "Your username or password is wrong";
            break;
          case 500:
            setState(EditState.failed);
            errorMessage = "Something went wrong please try agian later, 500";
            break;
          case 408:
            setState(EditState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later,408";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(EditState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
