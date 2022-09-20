import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/main.dart';
import 'package:bus/view/widgets/confirm_cancel_buttons.dart';
import 'package:bus/view_model/create_travel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class CreateTravelScreen extends StatefulWidget {
  const CreateTravelScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() =>CreateTravelScreenState();
  
}




class CreateTravelScreenState extends State<CreateTravelScreen>{
    TextEditingController travelNameController = TextEditingController();
  TextEditingController travelDescController = TextEditingController();
  TextEditingController travelAppointController = TextEditingController();

  @override
  void dispose() {
travelNameController.dispose();
travelDescController.dispose();
travelAppointController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    File? image;

    // double mWidth = (MediaQuery.of(context).size.width-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom);
    // double mHeight = MediaQuery.of(context).size.height;

    var provider = Provider.of<CreateTravelViewModel>(context);
    if (provider.state == TravelScreenState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 6))
          .show(context);
          provider.state=TravelScreenState.loaded;
    } else     if (provider.state == TravelScreenState.created) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
          provider.state=TravelScreenState.loaded;
    }

    return SafeArea(
      child:
       Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Create travel"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: provider.state==TravelScreenState.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
                : SingleChildScrollView(
                    child: Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        // image == null
                        //     ? Center(
                        //         child:
                        //         Padding(
                        //           padding: EdgeInsets.all(mHeight * 0.02),
                        //           child: Container(
                        //             width: mWidth * 0.6,
                        //             height: mHeight * 0.2,
                        //             decoration: const BoxDecoration(
                        //                 image: DecorationImage(
                        //                     image: AssetImage(
                        //                         "assets/images/placeholder.png"),
                        //                     fit: BoxFit.contain)),
                        //           ),
                        //         ),
                        //       )
                        //     : Image.file(image),
                        SizedBox(
                          // color: Colors.yellow,
                          width: double.infinity,
                          height: 25.h,
                          child: provider.img != null
                              ? Image.file(
                                    File(provider.img!.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  )
                              : Center(
                                  child: Icon(
                                  Ionicons.image_outline,
                                  size:140.dp,
                                  color: Colors.grey,
                                  
                                )),
                        ),
                        Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    provider.pickImage(ImageSource.gallery);
                                  },
                                  child: Text("Choose from Gallery")),
                              ElevatedButton(
                                  onPressed: () {
                                    provider.pickImage(ImageSource.camera);
                                  },
                                  child: Text("Choose from Camera")),
                            ],
                          ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.all(mHeight * 0.02),
                        //   child: Row(
                        //     children: [
                        //       Column(
                        //         children: [],
                        //       ),
                        //       Column(
                        //         children: [],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.all(1.w),
                          child: TextFormField(
                            controller: travelNameController,
                            // validator: (value) {
                            //   if (value!.length < 6) {
                            //     return "The password should be more than 6 digits";
                            //   }
                            // },
                            decoration: InputDecoration(
                                labelText: "Travel's name",
                                suffixIcon: Icon(
                                  Ionicons.location_outline,
                                  color: Colors.red,
                                )

                                // border: OutlineInputBorder()
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.w),
                          child: TextFormField(
                            controller: travelAppointController,
                            // validator: (value) {
                            //   if (value!.length < 6) {
                            //     return "The password should be more than 6 digits";
                            //   }
                            // },
                            decoration: InputDecoration(
                                labelText: "Travel's appointment",
                                suffixIcon: Icon(
                                  Ionicons.time_outline,
                                  color: Colors.yellow,
                                )

                                // border: OutlineInputBorder()
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.w),
                          child: TextFormField(
                            controller: travelDescController,
                            // validator: (value) {c
                            //   if (value!.length < 6) {
                            //     return "The password should be more than 6 digits";
                            //   }
                            // },
                            decoration: InputDecoration(
                                labelText: "Travel's description",
                                suffixIcon: Icon(
                                  Icons.description_outlined,
                                  color: Colors.green,
                                )

                                // border: OutlineInputBorder()
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SelectableText(
                                    "Number of sites :",
                                    style: TextStyle(fontSize: 18.dp),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  NumberPicker(
                                    value: provider.numOfSites,
                                    minValue: 10,
                                    maxValue: 100,
                                    onChanged: (value) {
                                      provider.pickNumber(value);
                                    },
                                  ),
                                  // SizedBox(
                                  //   height: mHeight * 0.05,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                          padding: EdgeInsets.all(1.w),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(30.w, 7.h)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      1.h),
                                              side: BorderSide(
                                                  color: Colors.blue)))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 16.dp,
                                        color: Colors.blue),
                                  ),
                                )),
                            Padding(
                          padding: EdgeInsets.all(1.w),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(30.w, 7.h)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      1.h),
                                              side: BorderSide(
                                                  color: Colors.blue)))),
                                  onPressed: () {
                                    provider.postTravel(context, travelNameController, travelDescController, travelAppointController);
                                    if(provider.state==TravelScreenState.created){
                                      
                                    }
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 16.dp,
                                        color: Colors.white),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  )),
      ),
    );
  }
  
}
