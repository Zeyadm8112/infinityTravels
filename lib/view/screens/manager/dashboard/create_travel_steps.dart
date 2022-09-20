// import 'dart:io';

// import 'package:bus/view/screens/manager/dashboard/create_destinations_screen.dart';
// import 'package:bus/view/screens/manager/dashboard/create_times_screen.dart';
// import 'package:bus/view/screens/manager/dashboard/create_travel_screen.dart';
// import 'package:bus/view_model/create_destinations_view_model.dart';
// import 'package:bus/view_model/create_times_view_model.dart';
// import 'package:bus/view_model/create_travel_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:provider/provider.dart';

// class CreateTravelStepsScreen extends StatefulWidget {
//   const CreateTravelStepsScreen({Key? key}) : super(key: key);

//   @override
//   State<CreateTravelStepsScreen> createState() => _CreateTravelStepsState();
// }

// class _CreateTravelStepsState extends State<CreateTravelStepsScreen> {
//       int currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
    
//     double mWidth = MediaQuery.of(context).size.width;
//     double mHeight = MediaQuery.of(context).size.height;
// final travelProvider=Provider.of<CreateTravelViewModel>(context);
// final destProvider=Provider.of<CreateDestinationsViewModel>(context);
// final timeProvider=Provider.of<CreateTimesViewModel>(context);

//     var _stepList = [
//       Step(
//           title: Text('Travel'),
//           content: Container(child:  travelProvider.loading
//             ? Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.red,
//                 ),
//               )
//             : travelProvider.error
//                 ? Center(child: Text("Something went wrong"))
//                 : SingleChildScrollView(
//                     child: Padding(
//                     padding: EdgeInsets.all(mHeight * 0.02),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SelectableText(
//                           "Bus picture :",
//                           style: TextStyle(fontSize: mHeight * 0.03),
//                         ),
//                         // image == null
//                         //     ? Center(
//                         //         child:
//                         //         Padding(
//                         //           padding: EdgeInsets.all(mHeight * 0.02),
//                         //           child: Container(
//                         //             width: mWidth * 0.6,
//                         //             height: mHeight * 0.2,
//                         //             decoration: const BoxDecoration(
//                         //                 image: DecorationImage(
//                         //                     image: AssetImage(
//                         //                         "assets/images/placeholder.png"),
//                         //                     fit: BoxFit.contain)),
//                         //           ),
//                         //         ),
//                         //       )
//                         //     : Image.file(image),
//                         Container(
//                           width: double.infinity,
//                           height: 200,
//                           child: travelProvider.img != null
//                               ? Center(
//                                   child: InteractiveViewer(
//                                       // clipBehavior: Clip.none,
//                                       maxScale: 1.5,
//                                       child:
//                                           //  Text("good"))
//                                           Image.file(
//                                         File(travelProvider.img!.path),
//                                         width: 100,
//                                         height: 100,
//                                         fit: BoxFit.contain,
//                                       )),
//                                 )
//                               : Center(
//                                   child: Icon(
//                                   Ionicons.image_outline,
//                                   size: mHeight * 0.3,
//                                   color: Colors.grey,
//                                 )),
//                         ),
//                         Center(
//                           child: Column(
//                             children: [
//                               ElevatedButton(
//                                   onPressed: () {
//                                     travelProvider.pickImage(ImageSource.gallery);
//                                   },
//                                   child: Text("Choose from Gallery")),
//                               ElevatedButton(
//                                   onPressed: () {
//                                     travelProvider.pickImage(ImageSource.camera);
//                                   },
//                                   child: Text("Choose from Camera")),
//                             ],
//                           ),
//                         ),

//                         // Padding(
//                         //   padding: EdgeInsets.all(mHeight * 0.02),
//                         //   child: Row(
//                         //     children: [
//                         //       Column(
//                         //         children: [],
//                         //       ),
//                         //       Column(
//                         //         children: [],
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: EdgeInsets.all(mHeight * 0.02),
//                           child: TextFormField(
//                             controller: travelProvider.travelNameController,
//                             // validator: (value) {
//                             //   if (value!.length < 6) {
//                             //     return "The password should be more than 6 digits";
//                             //   }
//                             // },
//                             decoration: InputDecoration(
//                                 labelText: "Travel's name",
//                                 suffixIcon: Icon(
//                                   Ionicons.location_outline,
//                                   color: Colors.red,
//                                 )

//                                 // border: OutlineInputBorder()
//                                 ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(mHeight * 0.02),
//                           child: TextFormField(
//                             controller: travelProvider.travelAppointController,
//                             // validator: (value) {
//                             //   if (value!.length < 6) {
//                             //     return "The password should be more than 6 digits";
//                             //   }
//                             // },
//                             decoration: InputDecoration(
//                                 labelText: "Travel's appointment",
//                                 suffixIcon: Icon(
//                                   Ionicons.time_outline,
//                                   color: Colors.yellow,
//                                 )

//                                 // border: OutlineInputBorder()
//                                 ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(mHeight * 0.02),
//                           child: TextFormField(
//                             controller: travelProvider.travelDescController,
//                             // validator: (value) {c
//                             //   if (value!.length < 6) {
//                             //     return "The password should be more than 6 digits";
//                             //   }
//                             // },
//                             decoration: InputDecoration(
//                                 labelText: "Travel's description",
//                                 suffixIcon: Icon(
//                                   Icons.description_outlined,
//                                   color: Colors.green,
//                                 )

//                                 // border: OutlineInputBorder()
//                                 ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(mHeight * 0.02),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Column(
//                                 children: [
//                                   SelectableText(
//                                     "Number of sites :",
//                                     style: TextStyle(fontSize: mHeight * 0.03),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   NumberPicker(
//                                     value: travelProvider.numOfSites,
//                                     minValue: 10,
//                                     maxValue: 100,
//                                     onChanged: (value) {
//                                       travelProvider.pickNumber(value);
//                                     },
//                                   ),
//                                   // SizedBox(
//                                   //   height: mHeight * 0.05,
//                                   // ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.end,
//                         //   children: [
//                         //     Padding(
//                         //         padding: EdgeInsets.all(mWidth * 0.01),
//                         //         child: ElevatedButton(
//                         //           style: ButtonStyle(
//                         //               minimumSize: MaterialStateProperty.all(
//                         //                   Size(mWidth * 0.3, mHeight * 0.07)),
//                         //               backgroundColor:
//                         //                   MaterialStateProperty.all(
//                         //                       Theme.of(context)
//                         //                           .scaffoldBackgroundColor),
//                         //               shape: MaterialStateProperty.all<
//                         //                       RoundedRectangleBorder>(
//                         //                   RoundedRectangleBorder(
//                         //                       borderRadius:
//                         //                           BorderRadius.circular(
//                         //                               mHeight * 0.01),
//                         //                       side: BorderSide(
//                         //                           color: Colors.blue)))),
//                         //           onPressed: () {
//                         //             Navigator.pop(context);
//                         //           },
//                         //           child: Text(
//                         //             "Cancel",
//                         //             style: TextStyle(
//                         //                 fontSize: mWidth * 0.04,
//                         //                 color: Colors.blue),
//                         //           ),
//                         //         )),
//                         //     Padding(
//                         //         padding: EdgeInsets.all(mWidth * 0.01),
//                         //         child: ElevatedButton(
//                         //           style: ButtonStyle(
//                         //               minimumSize: MaterialStateProperty.all(
//                         //                   Size(mWidth * 0.3, mHeight * 0.07)),
//                         //               backgroundColor:
//                         //                   MaterialStateProperty.all(
//                         //                       Colors.blue),
//                         //               shape: MaterialStateProperty.all<
//                         //                       RoundedRectangleBorder>(
//                         //                   RoundedRectangleBorder(
//                         //                       borderRadius:
//                         //                           BorderRadius.circular(
//                         //                               mHeight * 0.01),
//                         //                       side: BorderSide(
//                         //                           color: Colors.blue)))),
//                         //           onPressed: () {
//                         //             travelProvider.postTravel(context);
//                         //           },
//                         //           child: Text(
//                         //             "Next",
//                         //             style: TextStyle(
//                         //                 fontSize: mWidth * 0.04,
//                         //                 color: Colors.white),
//                         //           ),
//                         //         ))
//                         //   ],
//                         // )
//                       ],
//                     ),
//                   )),),
//           isActive: currentStep >= 0),
//       Step(
//           title: Text('Destinations'),
//           content: Container(child: ,

//           ),
//           isActive: currentStep >= 1),
//       Step(
//           title: Text('Times'),
//           content: Container(color: Colors.green),
//           isActive: currentStep >= 2)
//     ];

//     return SafeArea(
//       child: Scaffold(
//           body: SizedBox(
//         width: mWidth,
//         height: mHeight,
//         child: Stepper(
//           elevation: 0,
//           currentStep: currentStep,
//           type: StepperType.horizontal,
//           steps: _stepList,
//           // [
//           //   Step(title: Text("create"), content: Text('1')),
//           //   Step(title: Text("create"), content: Text('1')),
//           //   Step(title: Text("create"), content: Text('1')),
//           // ],
//           onStepContinue: () {

//            if(currentStep !=2){
//               setState(() =>currentStep++);
//           }  
//           },
//           onStepCancel: () {},
//         ),
//       )),
//     );
//   }
// }
