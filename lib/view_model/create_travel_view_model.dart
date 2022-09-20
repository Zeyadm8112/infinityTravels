import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bus/main.dart';
import 'package:bus/model/create_travels_model.dart';
import 'package:bus/view/screens/manager/dashboard/create_travel_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import '../consts/constants.dart';

enum TravelScreenState { intializing, loading, loaded, failed, created }

class CreateTravelViewModel extends ChangeNotifier {
  TravelScreenState state = TravelScreenState.intializing;
  setState(state) {
    this.state = state;
    notifyListeners();
  }

  String errorMessage = "";

  int? travelID;
  bool loading = false;
  bool error = false;
  File? img;
  // PickedFile? pickedImage;
  int _noOfSites = 50;
  late FormData formMap;

  int get numOfSites => _noOfSites;

  pickNumber(int val) {
    _noOfSites = val;
    notifyListeners();
  }

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
    File tmpFile = File(pickedImage.path);

    // 5. Get the path to the apps directory so we can save the file to it.
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String path = appDocumentsDirectory.path;

    final String fileExtension = extension(pickedImage.path); // e.g. '.jpg'

    // 6. Save the file by copying it to the new location on the device.
    tmpFile = await tmpFile.copy('$path/$fileName');
    fileName = "$fileName$fileExtension";
    this.fileName = fileName;
    // 7. Optionally, if you want to display the taken picture we need to update the state
    // Note: Copying and awaiting the file needs to be done outside the setState function.
    img = tmpFile;

    notifyListeners();
  }

  Future postTravel(BuildContext context, TextEditingController travelNameController,TextEditingController travelDescController,TextEditingController travelAppointController ) async {
setState(TravelScreenState.loading);
    var params = {
      'TravelName': travelNameController.text.toString(),
      'UserCreatorID': sharedPref!.getString('userID').toString(),
      'NoOfSites': _noOfSites.toString(),
      'TravelDescription': travelDescController.text.toString(),
      'TravelAppointment': travelAppointController.text.toString(),
    };
    var dio = Dio();
    try {
          FormData formData = FormData.fromMap({
      'SendFile': await MultipartFile.fromFile(img!.path, filename: fileName),
    });

      var response = await dio.post("$baseUrl/api/Travels",
          data: formData, queryParameters: params);

//   final Uri url=Uri.parse("http://icecode-001-site1.itempurl.com//api/Travels");
//  var bytes = img!.readAsBytesSync();

// http.MultipartRequest request = new http.MultipartRequest("POST", url);

      if (response.statusCode == 201) {
        var stringObject = Map<String, dynamic>.from(response.data);
        var result = CreateTravelModel.fromJson(stringObject);

        if (result.travelId != null) {
          loading = false;
          travelID = result.travelId;
          sharedPref!.setInt('id', result.travelId);
          setState(TravelScreenState.created);
          errorMessage="Travel created";
          
          Navigator.pushReplacementNamed(context, '/CreateDestinations',
              arguments: {'id': result.travelId});
      //  setState(TravelScreenState.loaded);
      //  img!.delete();
        }
      }
    } 
    on SocketException {
      errorMessage = "PLease check your connection";
      setState(TravelScreenState.failed);
    } on FormatException {
      errorMessage = "Error happened try agian later";
      setState(TravelScreenState.failed);
    } on TimeoutException {
      errorMessage = "Your internet connection is bad please try agian later";
      setState(TravelScreenState.failed);
    } on DioError catch (e) {
      _handleDioErrors(e);
    } catch (e){
          errorMessage = "Please fill the data";
      setState(TravelScreenState.failed);
  
    }
  }

  _handleDioErrors(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        setState(TravelScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later";
        break;
      case DioErrorType.sendTimeout:
        setState(TravelScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later";
        break;
      case DioErrorType.receiveTimeout:
        setState(TravelScreenState.failed);
        errorMessage =
            "Your internet connection is bad please try agian later";
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 404:
            setState(TravelScreenState.failed);
            errorMessage = "Please don't use Emojis";
            break;
          case 400:
            setState(TravelScreenState.failed);
            errorMessage = "You can't make two travels with one photo ";
            break;
          case 500:
            setState(TravelScreenState.failed);
            errorMessage = "Something went wrong please try agian later";
            break;
          case 408:
            setState(TravelScreenState.failed);
            errorMessage =
                "Your internet connection is bad please try agian later";
            break;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        setState(TravelScreenState.failed);
        errorMessage = "No internet connection";

        break;
    }
  }
}
