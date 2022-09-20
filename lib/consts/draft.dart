//     // try {
//     //   final image = await ImagePicker().pickImage(source: src);
//     //   if (image == null) return;
//     //   String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
//     //   final Directory extDir = await getApplicationDocumentsDirectory();
//     //   final String dirPath = "${extDir.path}/media";
//     //   await Directory(dirPath).create(recursive: true);
//     //   String imageName = img!.path.split('/').last;

//     //   final String filePath = "$dirPath/${imageName}";

//     //   // final imageTemporary = File(image.path);
//     //   img!.saveTo(filePath);
//     //   // img
//     //   // // .saveTo(filePath);
//     // } on PlatformException catch (e) {
//     //   print("$e");
//     // }
//     // var imagePicker = await ImagePicker().pickImage(source: src);
//     // if (imagePicker != null) {
//     //   img = imagePicker;
//     // }
//     // try {
//     //   String fileName = img!.path.split('/').last;
//     //   formMap = new FormData.fromMap({
//     //     'SendFile': await MultipartFile.fromFile(
//     //       img!.path,
//     //       filename: fileName,
//     //       contentType: new MediaType('image', 'png'),
//     //     ),
//     //     "type": "image/png"
//     //   });
//     // } catch (e) {}



// //----------------------------------------------------------------------------------------------------------------------------------------------------------  Future<http.StreamedResponse> postTravel(PickedFile? data) async {
//     loading = true;
//     // Map<String, String> headers = {
//     //   "accept": "*/*",
//     //   "Content-type": "multipart/form-data"
//     // };
//     // CreateTravelModel result;
//     // // List<Token> tokenList = [];
//     // // String fileName = img.toString();
//     // // FormData formMap = FormData.fromMap({
//     // //     'SendFile':await MultipartFile.fromFile(img!.path,filename: fileName)
//     // //   });
//     // // if (img != null) {
//     // //   // String base64=await base64Encode(img!.readAsBytesSync());
//     // // }
//     // String base64 = base64Encode(img!.readAsBytesSync());

//     // String imageName = img!.path.split('/').last;

//     // // var fileContent = img!.readAsBytesSync();
//     // // var fileContentBase64 = base64.encode(fileContent);

//     // var formMap = {
//     //   'SendFile': base64
//     // };
//     // var params = {
//     //   'TravelName': travelNameController.text.toString(),
//     //   'UserCreatorID': sharedPref!.getString('userID').toString(),
//     //   'NoOfSites': _noOfSites.toString(),
//     //   'TravelDescription': travelDescController.text.toString(),
//     //   'TravelAppointment': travelAppointController.text.toString(),
//     // };
//     // // final dio = Dio();

//     // // final response = await dio.post("http://icecode-001-site1.itempurl.com//api/Travels",
//     // //     queryParameters: params,
//     // //     data: formMap,
//     // //  options: Options(contentType: Headers.jsonContentType)
//     // //     );
//     // final response = await http.post(
//     //     Uri.http("icecode-001-site1.itempurl.com", "/api/Travels", params),
//     //     // headers: headers,
//     //     body: formMap);
//     // // final uri = Uri.parse('$baseUrl/api/Travels');
//     // if (response.statusCode == 200) {
//     //   loading = false;
//     //   // var stringObject = Map<String, dynamic>.from(response.body);
//     //   var result = createTravelModelFromJson(response.body);

//     //   // result = CreateTravelModel.fromJson(stringObject);
//     //   if (result.travelId != null) {
//     //     Navigator.pushReplacementNamed(context, '/CreateDestinations',
//     //         arguments: result.travelId);
//     //     error = false;
//     //   }
//     // } else {
//     //   loading = false;
//     //   print('${response.statusCode} : ${response.body.toString()}');
//     //   error = true;
//     //   throw "error";
//     // }
//     http.MultipartRequest request= http.MultipartRequest('POST',Uri.parse("icecode-001-site1.itempurl.com/api/Travels"
//     ));
//     if(data !=null){
//       File file=File(data.path);
//       request.files.add(http.MultipartFile('image',file.readAsBytes().asStream(),file.lengthSync(),filename: file.path.split('/').last));
//       // request.fields.
//     }
// http.StreamedResponse response = await request.send();
// return response;
//   }
//-------------------------------------------------------------------------------------------------------------------    // final dio = Dio();

    // final response = await dio.post("http://icecode-001-site1.itempurl.com//api/Travels",
    //     queryParameters: params,
    //     data: formMap,
    //  options: Options(contentType: Headers.jsonContentType)
    //     );
    // final response = await http.post(
    //     Uri.http("icecode-001-site1.itempurl.com", "/api/Travels", params),
    //     // headers: headers,
    //     body: formMap);
    // // final uri = Uri.parse('$baseUrl/api/Travels');
    // if (response.statusCode == 200) {
    //   loading = false;
    //   // var stringObject = Map<String, dynamic>.from(response.body);
    //   var result = createTravelModelFromJson(response.body);

    //   // result = CreateTravelModel.fromJson(stringObject);
    //   if (result.travelId != null) {
    //     Navigator.pushReplacementNamed(context, '/CreateDestinations',
    //         arguments: result.travelId);
    //     error = false;
    //   }
    // } else {
    //   loading = false;
    //   print('${response.statusCode} : ${response.body.toString()}');
    //   error = true;
    //   throw "error";
    // }

  //   var stream =  http.ByteStream(img!.openRead());
  //   stream.cast();
  // // var stream=   http.ByteStream(DelegatingStream.typed(img!.openRead()));
  //   var length = await img!.length();
  //   var uri = Uri.parse(
  //       "http://icecode-001-site1.itempurl.com//api/Travels?TravelName=scn&UserCreatorID=80632ab3-aea2-45f3-8b09-7245c721901e&NoOfSites=40&TravelDescription=good&TravelAppointment=late");
  //   var request = http.MultipartRequest('POST', uri);
  //   // request.fields
  //   var multiPart = http.MultipartFile('SendFile', stream, length);
  //   request.files.add(multiPart);
// //----------------------------------------------------------------------------------------------------------------------------------------------------------  Future<http.StreamedResponse> postTravel(PickedFile? data) async {
  //   var myRequest = await request.send();
  //   var response = await http.Response.fromStream(myRequest);

  // final Uri url= Uri.parse("http://icecode-001-site1.itempurl.com//api/Travels?TravelName=${travelNameController.text.toString()}&UserCreatorID=${sharedPref!.getString('userID').toString()}&NoOfSites=${_noOfSites.toString()}&TravelDescription=${travelDescController.text.toString()}TravelAppointment=${travelAppointController.text.toString()}");
  //  var response = await http.post(
  //       url,
  //       headers:{ "Content-Type":"multipart/form-data" } ,
  //       body: { 'SendFile' , img},
  //       encoding: Encoding.getByName("utf-8")
  //   );
  // var postUri = Uri.parse("apiUrl");
//-------------------------------------------------------------------------------------------------------// http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
//     'SendFile', img!.path); 
//     var header = {
//   "Content-Type": 'multipart/form-data',
//   "Accept": 'application/json'
// };
// request.fields.addAll(params);
// request.headers.addAll(header);
// request.files.add(multipartFile);
// request.fields['TravelName']=travelNameController.text.toString();
// request.fields['UserCreatorID']=sharedPref!.getString('userID').toString();
// request.fields['NoOfSites']= _noOfSites.toString();
// request.fields['TravelDescription']= travelDescController.text.toString();
// request.fields['TravelAppointment']=  travelAppointController.text.toString();
//  request.fields["params"]=json.encode(params);


// http.StreamedResponse response = await request.send();
    // Map<String, String> headers = {
    //   "accept": "*/*",
    //   "Content-type": "multipart/form-data"
    // };
    // CreateTravelModel result;
    // List<Token> tokenList = [];
    // String fileName = img.toString();
    // FormData formMap = FormData.fromMap({
    //     'SendFile':await MultipartFile.fromFile(img!.path,filename: fileName)
    //   });
    // if (img != null) {
    //   // String base64=await base64Encode(img!.readAsBytesSync());
    // }
    // String base64 = base64Encode(img!.readAsBytesSync());

    // String imageName = img!.path.split('/').last;

    // var fileContent = img!.readAsBytesSync();
    // var fileContentBase64 = base64.encode(fileContent);

    // var formMap = {'SendFile': base64};
    // var params = {
    //   'TravelName': json.encode( travelNameController.text.toString()),
    //   'UserCreatorID': json.encode(sharedPref!.getString('userID').toString()),
    //   'NoOfSites':json.encode( _noOfSites.toString()),
    //   'TravelDescription':json.encode( travelDescController.text.toString()),
    //   'TravelAppointment':json.encode( travelAppointController.text.toString()),
    // };
    // String travelName = ;
    // String travelDesc = ;
    // String travelAppoint =;

    // print()
// Padding(
//           padding: EdgeInsets.all(3.w),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             SizedBox(
//               height: 2.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   " Destinations Go ",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Cairo',
//                       fontSize: 18.dp,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Icon(
//                   Ionicons.arrow_forward,
//                   size: 18.dp,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 2.h,
//             ),
//             FutureBuilder(
//                 future: provider.getDestGo(),
//                 builder: (context, snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.waiting:
//                       return Center(
//                         child: CircularProgressIndicator(color: Colors.blue),
//                       );

//                     case ConnectionState.done:

//                     default:
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("error"),
//                         );
//                       } else if (snapshot.hasData) {
//                         return SizedBox(
//                           width: 100.w,
//                           height: 30.h,
//                           child: ListView.builder(
//                               itemCount: provider.destGoList!.length,
//                               itemBuilder: ((context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(1.0),
//                                   child: InkWell(
//                                     onTap: (){
//                                      Navigator.pushNamed(
//                                           context, '/DestiantionsByTravel', arguments: {
//                                         'id':travelId,
//                                         'go':'yes'

//                                       });
//                                     },

//                                     child: Container(
//                                       width: 67.w,
//                                       height: 12.h,
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(2.h)),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(provider
//                                                 .destGoList![index]
//                                                 .destinationName),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               })),
//                         );
//                       } else {
//                         return Text("noData");
//                       }
//                   }
//                 }),
//             SizedBox(
//               height: 2.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   " Destinations Back ",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Cairo',
//                       fontSize: 18.dp,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Icon(
//                   Ionicons.arrow_forward,
//                   size: 18.dp,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 2.h,
//             ),
//             FutureBuilder(
//                 future: provider.getDestBack(),
//                 builder: (context, snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.waiting:
//                       return Center(
//                         child: CircularProgressIndicator(color: Colors.blue),
//                       );

//                     case ConnectionState.done:

//                     default:
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("error"),
//                         );
//                       } else if (snapshot.hasData) {
//                         return SizedBox(
//                           width: 100.w,
//                           height: 30.h,
//                           child: ListView.builder(
//                               itemCount: provider.destBackList!.length,
//                               itemBuilder: ((context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(1.0),
//                                   child: Container(
//                                     width: 67.w,
//                                     height: 12.h,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(2.h)),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(provider
//                                               .destBackList![index]
//                                               .destinationNameB),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               })),
//                         );
//                       } else {
//                         return Text("noData");
//                       }
//                   }
//                 }),
//           ])),