import 'dart:async';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:bus/view_model/edit_travel_view_model.dart';
import 'package:bus/view_model/create_times_view_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_colors.dart';
import '../../../../model/travel_model.dart';
import '../../../widgets/error_widget.dart';
import '../../image_view_screen.dart';

class EditTravelScreen extends StatefulWidget {
  const EditTravelScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>  _EditTravelScreenState();
}

class _EditTravelScreenState extends State<EditTravelScreen> {
  StreamController _controller = StreamController<Travel>();
  StreamController _destGocontroller = StreamController<Travel>();
  final formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   var provider = Provider.of<EditTravelViewModel>(context, listen: false);
  //   provider.getStreamedTravel(45, _controller);
  //   // TODO: implement initState

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _controller.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _destGocontroller = TextEditingController();
    EditTravelViewModel s = EditTravelViewModel();
    var provider = Provider.of<EditTravelViewModel>(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int travelId = arg['id'];
    String travelName = arg['name'];
    // provider.travelId = travelId;

    // provider.getTravel(travelId);

    // double mWidth = MediaQuery.of(context).size.width;
    // double mHeight = MediaQuery.of(context).size.height;
    // if (provider.state == EditState.failed) {
    //   AnimatedSnackBar.material(provider.errorMessage,
    //           type: AnimatedSnackBarType.error,
    //           mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    //           duration: const Duration(seconds: 6))
    //       .show(context);
    //   provider.state = EditState.intial;
    // } else if (provider.state == CreateTimesScreenState.created) {
    //   AnimatedSnackBar.material(provider.errorMessage,
    //           type: AnimatedSnackBarType.success,
    //           mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    //           duration: const Duration(seconds: 3))
    //       .show(context);
    //   provider.state = EditState.intial;
    // }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            travelName,
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 22.dp),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body:
            // provider.loading
            //     ? Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.red,
            //         ),
            //       )
            //     : provider.error
            //         ? Center(child: const Text("Something went wrong"))
            //         :
            RefreshIndicator(
          onRefresh: () async {
setState(() {
  
});
          },
          child: SingleChildScrollView(
              child: Column(children: [
            FutureBuilder(
                future:             provider.getTravel(travelId),

                builder: (((context, snapshot) {
                  // _controller.sink.add(provider.travel);

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );

                    case ConnectionState.done:

                    default:
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          "error ",
                          style: TextStyle(
                              fontSize: 15.dp,
                              color: AppColors.secondaryColor,
                              fontFamily: 'Cairo'),
                        ));
                      } else if (snapshot.hasData) {
                        return Column(children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageViewScreen(
                                            "$baseUrl/Content/IMG/${provider.travel!.imagePath}")));
                              },
                              child:
                               Container(
                                // color: Colors.red,
                                width: 100.w,
                                height: 30.h,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                    "$baseUrl/Content/IMG/${provider.travel!.imagePath}",
                                    frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) =>
                                        child,
                                    loadingBuilder:
                                        ((context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox(
                                          width: 2.w,
                                          height: 1.h,
                                          child: Image.asset(
                                            'assets/images/error.png',
                                            fit: BoxFit.contain,
                                          ));
                                    },
                                  ),
                                ),
                                //   return
                                // width: mWidth * 0.4,
                                // height: mHeight * 0.2,
                                // fit: BoxFit.cover,
                              )),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 7.h,
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 15.dp,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Center(
                                          child: Icon(
                                            Ionicons.text,
                                            color: AppColors.secondaryColor,
                                            size: 14.dp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        // color: Colors.red,
                                        width: 65.w,
                                        height: 5.h,
                                        child: SelectableText(
                                          provider.travel!.travelName,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18.dp,
                                              color: AppColors.primaryColor,
                                              height: 1.2),
                                          // textScaleFactor: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 7.h,
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 15.dp,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Center(
                                          child: Icon(
                                            Ionicons.time,
                                            color: AppColors.secondaryColor,
                                            size: 14.dp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        // color: Colors.red,
                                        width: 65.w,
                                        height: 5.h,
                                        child: SelectableText(
                                          provider.travel!.travelAppointment,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18.dp,
                                              color: AppColors.primaryColor,
                                              height: 1.2),
                                          // textScaleFactor: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 7.h,
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 15.dp,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Center(
                                          child: Icon(
                                            Ionicons.person,
                                            color: AppColors.secondaryColor,
                                            size: 14.dp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        // color: Colors.red,
                                        width: 65.w,
                                        height: 5.h,
                                        child: SelectableText(
                                          provider.travel!.userName,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18.dp,
                                              color: AppColors.primaryColor,
                                              height: 1.2),
                                          // textScaleFactor: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: provider.getDate(travelId),
                              builder: ((context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.blue),
                                    );

                                  case ConnectionState.done:

                                  default:
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                        "error ",
                                        style: TextStyle(
                                            fontSize: 15.dp,
                                            color: AppColors.secondaryColor,
                                            fontFamily: 'Cairo'),
                                      ));
                                    } else if (snapshot.hasData) {
                                      return Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            height: 7.h,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 3.w, right: 3.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15.dp,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    child: Center(
                                                      child: Icon(
                                                        Ionicons.person,
                                                        color: AppColors
                                                            .secondaryColor,
                                                        size: 14.dp,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    // color: Colors.red,
                                                    width: 65.w,
                                                    height: 5.h,
                                                    child: SelectableText(
                                                      provider.time!,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 16.dp,
                                                          color: AppColors
                                                              .primaryColor,
                                                          height: 1.2),
                                                      // textScaleFactor: 0.8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SnapErrorWidget();
                                    }
                                }
                              })),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Card(
                                child: ExpansionTile(
                                    title: Text(
                                      'Description',
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 18.dp,
                                          fontFamily: 'Cairo'),
                                    ),
                                    children: [
                                  SizedBox(
                                      width: 100.w,
                                      height: 60.h,
                                      child: ListView(
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: ExpandableText(
                                                provider
                                                    .travel!.travelDescription,
                                                expandText: 'Show More',
                                                collapseText: 'Show less',
                                              ),
                                            ),
                                          ]))
                                ])),
                          ),
                        ]);
                      } else {
                        return SnapErrorWidget();
                      }
                  }
                }))),

            //   child: 
            // Center(
            //   child:
            //       provider.date == null ? Text("") : Text(provider.date!),
            // ),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.dp,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            provider.datePicker(context);
                          },
                          child: Text("Set Date")),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Destinations Goes",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.dp,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Ionicons.time_outline,
                        size: 22.dp,
                      )
                    ],
                  ),
                  // Center(
                  //   child: Text(provider.travelId.toString()),
                  // ),
                  SizedBox(
                    width: 100.w,
                    height: 40.h,
                    child: FutureBuilder(
                      future: provider.getDestGo(travelId),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child:
                                  CircularProgressIndicator(color: Colors.blue),
                            );

                          case ConnectionState.done:

                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("error"),
                              );
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: provider.destGoList.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(1.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 70.w,
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(2.h)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(provider
                                                      .destGoList[index]
                                                      .destinationName!),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ElevatedButton(
                                          //   child: Text("Set time"),
                                          //   onPressed: () async {

                                          // provider.deleteDestGo(provider
                                          //     .destBackList![index]
                                          //     .destinationBackId);
                                          // },
                                          // )
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2.h)),
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor,
                                                      ),
                                                      child: Center(
                                                        child: Form(
                                                          key: formKey,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    1.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    'Edit ${provider.destGoList[index].destinationName!}'),
                                                                TextFormField(
                                                                  controller:
                                                                      _destGocontroller,
                                                                  validator:
                                                                      (val) {
                                                                    if (val ==
                                                                            null ||
                                                                        val.isEmpty) {
                                                                      'Please enter the new name';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                                ElevatedButton(
                                                                    child: const Text(
                                                                        'Save'),
                                                                    onPressed:
                                                                        () {
                                                                      if (formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        provider.editDestGo(
                                                                            provider.destGoList[index].destinationGoID,
                                                                            _destGocontroller.text);
// Navigator.pop(context);

                                                                      }
                                                                    }),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                width: 8.w,
                                                height: 8.w,
                                                child: Icon(Icons.edit,
                                                    color: Colors.blue)),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Delete destination'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <
                                                            Widget>[
                                                          Text(
                                                              'Are you sure you want do delet this destination?'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child:
                                                            const Text('Yes'),
                                                        onPressed: () {
                                                          provider.deleteDestGo(
                                                              provider
                                                                  .destGoList[
                                                                      index]
                                                                  .destinationGoID);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                width: 8.w,
                                                height: 8.w,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              provider.timePickerGO(
                                                  context,
                                                  provider.destGoList[index]
                                                      .destinationGoID);
                                                      
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                width: 8.w,
                                                height: 8.w,
                                                child: Icon(
                                                  Ionicons.time,
                                                  color: Colors.green,
                                                )),
                                          )
                                        ],
                                      ),
                                    );
                                  }));
                            } else {
                              return Center(child: Text("noData"));
                            }
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Add Times to back",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.dp,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Ionicons.time_outline,
                        size: 22.dp,
                      )
                    ],
                  ),

                  // Center(
                  //   child: Text(provider.travelId.toString()),
                  // ),
                  SizedBox(
                    width: 100.w,
                    height: 40.h,
                    child: FutureBuilder(
                      future: provider.getDestBack(travelId),
                      builder: ((context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child:
                                  CircularProgressIndicator(color: Colors.blue),
                            );

                          case ConnectionState.done:

                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("error"),
                              );
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: provider.destBackList.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(1.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 70.w,
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(2.h)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(provider
                                                      .destBackList[index]
                                                      .destinationNameB!),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ElevatedButton(
                                          //   child: Text("Set time"),
                                          //   onPressed: () async {

                                          // provider.deleteDestGo(provider
                                          //     .destBackList![index]
                                          //     .destinationBackId);
                                          // },
                                          // )
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2.h)),
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor,
                                                      ),
                                                      child: Center(
                                                        child: Form(
                                                          key: formKey,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    1.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    'Edit ${provider.destBackList[index].destinationNameB!}'),
                                                                TextFormField(
                                                                  controller:
                                                                      _destGocontroller,
                                                                  validator:
                                                                      (val) {
                                                                    if (val ==
                                                                            null ||
                                                                        val.isEmpty) {
                                                                      'Please enter the new name';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                                ElevatedButton(
                                                                    child: const Text(
                                                                        'Save'),
                                                                    onPressed:
                                                                        () {
                                                                      if (formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        provider.editDestBack(
                                                                            provider.destBackList[index].destinationBackId,
                                                                            _destGocontroller.text);
// Navigator.pop(context);

                                                                      }
                                                                    }),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                width: 8.w,
                                                height: 8.w,
                                                child: Icon(Icons.edit,
                                                    color: Colors.blue)),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Delete destination'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <
                                                            Widget>[
                                                          Text(
                                                              'Are you sure you want do delet this destination?'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child:
                                                            const Text('Yes'),
                                                        onPressed: () {
                                                          provider.deleteDestBack(
                                                              provider
                                                                  .destBackList[
                                                                      index]
                                                                  .destinationBackId);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                width: 8.w,
                                                height: 8.w,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              provider.timePickerBack(
                                                  context,
                                                  provider.destBackList[index]
                                                      .destinationBackId);
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                width: 8.w,
                                                height: 8.w,
                                                child: Icon(
                                                  Ionicons.time,
                                                  color: Colors.green,
                                                )),
                                          )
                                        ],
                                      ),
                                    );
                                  }));
                            } else {
                              return Center(
                                child: Text("nodata"),
                              );
                            }
                        }
                      }),
                    ),
                  )
                ],
              ),
            ),
                        Padding(
              padding: EdgeInsets.all(2.w),
              child: FutureBuilder(
              future: provider.getTravel(travelId),
                builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );

                  case ConnectionState.done:

                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("error"),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Bus picture :",
                            style: TextStyle(fontSize: 18.dp),
                          ),
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
                          Container(
                            // color: Colors.yellow,
                            width: double.infinity,
                            height: 30.h,
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
                                    size: 30.dp,
                                    color: Colors.grey,
                                  )),
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 200,
                          //   child: Center(
                          //       child:
                          //       provider.img==null?
                          //        Image.network(
                          //     provider.travel != null
                          //         ? "$baseUrl/Content/IMG/${provider.travel!.imagePath}"
                          //         : imageUrl,
                          //     frameBuilder: (context, child, frame,
                          //             wasSynchronouslyLoaded) =>
                          //         child,
                          //     loadingBuilder: ((context, child, loadingProgress) {
                          //       if (loadingProgress == null) {
                          //         return child;
                          //       } else {
                          //         return Center(
                          //           child: SizedBox(
                          //             width: mWidth * 0.01,
                          //             height: mHeight * 0.01,
                          //             child: CircularProgressIndicator(
                          //               strokeWidth: mWidth * 0.01,
                          //               color: Colors.red,
                          //             ),
                          //           ),
                          //       );
                          //     }
                          //   }),
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return SizedBox(
                          //         width: mWidth * 0.02,
                          //         height: mHeight * 0.01,
                          //         child: Image.asset(
                          //           'assets/images/error.png',
                          //           fit: BoxFit.contain,
                          //         ));
                          //   },
                          // )
                          // :Image.file(
                          //           File(provider.img!.path),
                          //           width: 100,
                          //           height: 100,
                          //           fit: BoxFit.fitWidth,
                          //         ))
                          // ),

                          Center(
                            child: Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      provider.imageEdited = true;
                                      provider
                                          .pickImage(ImageSource.gallery);
                                    },
                                    child: Text("Choose from Gallery")),
                                ElevatedButton(
                                    onPressed: () {
                                      provider.imageEdited = true;
                                      provider
                                          .pickImage(ImageSource.camera);
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
                            padding: EdgeInsets.all(2.w),
                            child: TextFormField(
                              controller: provider.travelNameController,
                              // validator: (value) {
                              //   if (value!.length < 6) {
                              //     return "The password should be more than 6 digits";
                              //   }
                              // },,
                              onChanged: (text) {
                            
                                  provider.nameEdited = true;
                              
                              },
                              decoration: InputDecoration(
                                  hintText: provider.travel?.travelName ??
                                      'Travel name',
                                  suffixIcon: Icon(
                                    Ionicons.location_outline,
                                    color: Colors.red,
                                  )

                                  // border: OutlineInputBorder()
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: TextFormField(
                              controller:
                                  provider.travelAppointController,
                              onChanged: (text) {
                                // setState(() {
                                  provider.appointEdited = true;
                                // });
                              },

                              // validator: (value) {
                              //   if (value!.length < 6) {
                              //     return "The password should be more than 6 digits";
                              //   }
                              decoration: InputDecoration(
                                  hintText: provider
                                          .travel?.travelAppointment ??
                                      'Appointment',
                                  suffixIcon: Icon(
                                    Ionicons.time_outline,
                                    color: Colors.yellow,
                                  )

                                  // border: OutlineInputBorder()
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: TextFormField(
                              controller: provider.travelDescController,
                              onChanged: (text) {
                                
                                  provider.descEdited = true;
                                
                              },

                              // validator: (value) {c
                              //   if (value!.length < 6) {
                              //     return "The password should be more than 6 digits";
                              //   }
                              decoration: InputDecoration(
                                  hintText: provider
                                          .travel?.travelDescription ??
                                      'Descrpition',
                                  suffixIcon: Icon(
                                    Icons.description_outlined,
                                    color: Colors.green,
                                  )

                                  // border: OutlineInputBorder()
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Number of sites :",
                                      style: TextStyle(
                                          fontSize: 18.dp),
                                    ),
                                  ],
                                ),
                                // Column(
                                //   children: [
                                //     NumberPicker(
                                //       value: provider.travel?.noOfSites ??
                                //           10,
                                //       minValue: 10,
                                //       maxValue: 100,
                                //       onChanged: (value) {
                                //         provider.pickNumber(value);
                                //           provider.sitesEdited = true;
                                //       },
                                //     ),
                                //     // SizedBox(
                                //     //   height: mHeight * 0.05,
                                //     // ),
                                //   ],
                                // ),
                                Container(
                                  width: 30.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
borderRadius: BorderRadius.all(Radius.circular(2.h)
                                  ),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: provider.numberOfSiteController,
                                  textAlign: TextAlign.center,
                                                                onChanged: (text) {
                                
                                  provider.sitesEdited = true;
                                
                                                                },
                                decoration: InputDecoration(
                                  
                                  border: InputBorder.none,
                                  hintText: provider.travel!.noOfSites.toString()
                                ),
                                ),
                            )],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Padding(
                          //   padding: EdgeInsets.all(2.w),
                          //         child: ElevatedButton(
                          //           style: ButtonStyle(
                          //               minimumSize:
                          //                   MaterialStateProperty.all(Size(
                          //                       30.w,
                          //                       7.h)),
                          //               backgroundColor: MaterialStateProperty.all(
                          //                   Theme.of(context)
                          //                       .scaffoldBackgroundColor),
                          //               shape: MaterialStateProperty.all<
                          //                       RoundedRectangleBorder>(
                          //                   RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(
                          //                               1.h),
                          //                       side: BorderSide(color: Colors.blue)))),
                          //           onPressed: () {
                          //             provider.deleteTravel(travelId);
                          //           },
                          //           child: Text(
                          //             "Cancel",
                          //             style: TextStyle(
                          //                 fontSize: 16.dp,
                          //                 color: Colors.blue),
                          //           ),
                          //         )),
                          //     Padding(
                          //   padding: EdgeInsets.all(2.w),
                          //         child: ElevatedButton(
                          //           style: ButtonStyle(
                          //               minimumSize:
                          //                   MaterialStateProperty.all(Size(
                          //                       mWidth * 0.3,
                          //                       mHeight * 0.07)),
                          //               backgroundColor:
                          //                   MaterialStateProperty.all(
                          //                       Colors.blue),
                          //               shape: MaterialStateProperty.all<
                          //                       RoundedRectangleBorder>(
                          //                   RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(
                          //                               mHeight * 0.01),
                          //                       side:
                          //                           BorderSide(color: Colors.blue)))),
                          //           onPressed: () {
                          //             provider.editTravel(context,travelId);
                          //             Navigator.pushReplacementNamed(
                          //                 context, '/DashBoardScreen');
                          //           },
                          //           child: Text(
                          //             "Confirm",
                          //             style: TextStyle(
                          //                 fontSize: mWidth * 0.04,
                          //                 color: Colors.white),
                          //           ),
                          //         ))
                          //   ],
                          // )
                        ],
                      );
                    } else {
                      return Text("noData");
                    }
                }
              }),
            )

            // provider.destBackList! == []
            //     ? Container()
            //     :
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.all( 1.w),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(30.w, 7.h)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).scaffoldBackgroundColor),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(1.h),
                                  side: BorderSide(color: Colors.blue)))),
                      onPressed: () {
                        provider.deleteTravel(travelId);

                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize:16.dp, color: Colors.blue),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(1.w),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size( 30.w, 7.h)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(1.h),
                                  side: BorderSide(color: Colors.blue)))),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/ConfirmTravelScreen',
                        //     arguments: {'id': travelId});
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/MainScreen', (route) => true);
provider.editTravel(context,travelId);
                        AnimatedSnackBar.material(
                                "Travel created successfully",
                                type: AnimatedSnackBarType.success,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.bottom,
                                duration: const Duration(seconds: 3))
                            .show(context);
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 16.dp, color: Colors.white),
                      ),
                    ))
              ],
            )
          ])),
        ),
      ),
    );
  }
}
