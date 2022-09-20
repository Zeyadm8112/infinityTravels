import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/consts/app_colors.dart';
import 'package:bus/view/widgets/error_widget.dart';
import 'package:bus/view_model/edit_traveler_view_model.dart';
import 'package:bus/view_model/travel_info_view_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../view_model/accounts_info_view_model.dart';
import '../../../../view_model/traveler_view_model.dart';
import '../../../consts/constants.dart';
import '../../../model/time_back.dart';
import '../../../model/time_go.dart';
import '../image_view_screen.dart';

class EditTravelerScreen extends StatefulWidget {
  const EditTravelerScreen({Key? key}) : super(key: key);

  @override
  State<EditTravelerScreen> createState() => _EditTravelerScreenState();
}

class _EditTravelerScreenState extends State<EditTravelerScreen> {
  TextEditingController _codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  // void initState() {
  //   final provider = Provider.of<TravelerViewModel>(context,listen: false);
  //   provider.getTraveler();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EditTravelerViewModel>(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int travelId = arg['travelId'];
    int travelerId = arg['id'];
    String travelName = arg['name'];
    bool isChecked = false;

    // var provider = Provider.of<TravelInfoViewModel>(context);
    Future openDialogTimesGo(String location, int destId) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  title: Text("location"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          provider.selectedDestGoID = destId;
                          Navigator.pop(context);
                        },
                        child: Text('Select')),
                  ],
                  content: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(isChecked == false
                            ? location
                            // : provider.timeGo?[0].time==null?
                            : DateFormat('hh:mm')
                                .format(provider.timeGo![0]?.time ?? '0:0')
                        // 'loading..'
                        ),
                    value: isChecked,
                    onChanged: ((value) => setState(() {
                          isChecked = value!;
                          provider.selectedTimeGoID =
                              provider.timeGo?[0].timeGoId;
                        })),
                  ),
                ))));
    Future openDialogTimesBack(String location, int destId) => showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: ((context, setState) {
              final DateTime basicTime = DateTime.parse('1969-07-20 00:00:00Z');

              return AlertDialog(
                title: Text("location"),
                actions: [
                                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),

                  TextButton(
                      onPressed: () {
                        provider.selectedDestBackID = destId;
                        // provider.selectedTimeBackID = timeId;

                        Navigator.pop(context);
                      },
                      child: Text('ok'))
                ],
                content: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(isChecked == false
                      ? location
                      : DateFormat('hh:mm')
                          .format(provider.timeBack?[0].timeB ?? '0:0')),
                  value: isChecked,
                  onChanged: ((value) => setState(() {
                        isChecked = value!;
                        provider.selectedTimeBackID =
                            provider.timeBack?[0].timeBackId ?? '0:0';
                      })),
                ),
              );
            }),
          ),
        );
            if (provider.state == EditTravelerState.loading) {
return SafeArea(child: Scaffold(backgroundColor: Colors.white,body: Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)),))          ;  }
  else  if (provider.state == EditTravelerState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 6))
          .show(context);
      provider.state = EditTravelerState.loaded;
    } else if (provider.state == EditTravelerState.success) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
      provider.state = EditTravelerState.loaded;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            travelName,
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 25.dp),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height:provider.selectedSchedule == 2? 120.h:100.h,
            width: 100.w,
            child: RefreshIndicator(
              onRefresh: ()async{
                setState(() {
                  
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.05.w),
                    child: Column(children: [
                      SizedBox(
                        height: 30.h,
                        child: FutureBuilder(
                          future: provider.getTraveler(travelerId),
                          builder: ((context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.primaryColor),
                                );
            
                              case ConnectionState.done:
            
                              default:
                                if (snapshot.hasError) {
                                  return SnapErrorWidget();
                                } else if (snapshot.hasData) {
                                  // return Center(child: Text("data"),);
                                  return Column(
                                    // title: Text(
                                    //   provider.traveler![index].userName,
                                    //   style: TextStyle(
                                    //       fontSize: 17.dp,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.keyboard_arrow_right_outlined,
                                            color: Colors.red,
                                          ),
                                          title: SelectableText(
                                              provider.traveler!.destinationName
                                                      ?.toString() ??
                                                  "",
                                              style: TextStyle(fontSize: 15.dp)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.keyboard_arrow_left_outlined,
                                            color: Colors.red,
                                          ),
                                          title: SelectableText(
                                              provider.traveler!.destinationNameB
                                                      ?.toString() ??
                                                  "",
                                              style: TextStyle(fontSize: 15.dp)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.payment_outlined,
                                            color: Colors.red,
                                          ),
                                          title: SelectableText(
                                              provider.traveler!.referenceNo,
                                              style: TextStyle(fontSize: 15.dp)),
                                        ),
                                      ),
            
                                      // ListTile(
                                      //     leading: Icon(
                                      //         Icons
                                      //             .call,
                                      //         color: Colors.green),
                                      //     title: InkWell(
                                      //     onTap:()async{
                                      //     launch('tel://${   provider.traveler![index].phoneNumber
                                      //              }');
            
                                      //     },
                                      //       child: Text(
                                      //         provider.traveler!.
                                      //               ,
                                      //           style: TextStyle(
                                      //               fontSize: 15.dp)),
                                      //     ))
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: Text("empty"),
                                  );
                                }
                            }
                          }),
                        ),
                      ),
                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      Form(
                        key: formKey,
                        child: Column(children: [
                          // SizedBox(
                          //   width: 100.w,
                          //   height: 30.h,
                          //   child: FutureBuilder(
                          //     future: provider.getTravel(travelId),
                          //     builder: ((context, snapshot) {
                          //       switch (snapshot.connectionState) {
                          //         case ConnectionState.waiting:
                          //           return Center(
                          //             child: CircularProgressIndicator(
                          //                 color: AppColors.primaryColor),
                          //           );
                          
                          //         case ConnectionState.done:
                          
                          //         default:
                          //           if (snapshot.hasError) {
                          //             return Center(
                          //                 child: Text(
                          //               "error ",
                          //               style: TextStyle(
                          //                   fontSize: 15.dp,
                          //                   color: AppColors.secondaryColor,
                          //                   fontFamily: 'Cairo'),
                          //             ));
                          //           } else if (snapshot.hasData) {
                          //             return InkWell(
                          //                 onTap: () {
                          //                   Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               ImageViewScreen(
                          //                                   "$baseUrl/Content/IMG/${provider.travel!.imagePath}")));
                          //                 },
                          //                 child: Container(
                          //                   // color: Colors.red,
                          //                   width: 100.w,
                          //                   height: 30.h,
                          //                   child: FittedBox(
                          //                     fit: BoxFit.fill,
                          //                     child: Image.network(
                          //                       "$baseUrl/Content/IMG/${provider.travel!.imagePath}",
                          //                       frameBuilder: (context,
                          //                               child,
                          //                               frame,
                          //                               wasSynchronouslyLoaded) =>
                          //                           child,
                          //                       loadingBuilder: ((context, child,
                          //                           loadingProgress) {
                          //                         if (loadingProgress == null) {
                          //                           return child;
                          //                         } else {
                          //                           return Container();
                          //                         }
                          //                       }),
                          //                       errorBuilder:
                          //                           (context, error, stackTrace) {
                          //                         return SizedBox(
                          //                             width: 2.w,
                          //                             height: 1.h,
                          //                             child: Image.asset(
                          //                               'assets/images/error.png',
                          //                               fit: BoxFit.contain,
                          //                             ));
                          //                       },
                          //                     ),
                          //                   ),
                          //                   //   return
                          //                   // width: mWidth * 0.4,
                          //                   // height: mHeight * 0.2,
                          //                   // fit: BoxFit.cover,
                          //                 ));
                          //           } else {
                          //             return SnapErrorWidget();
                          //           }
                          //       }
                          //     }),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          // FutureBuilder(
                          //     future: provider.fetchTravel(travelId),
                          //     builder: (context, snapshot) {
                          //       switch (snapshot.connectionState) {
                          //         case ConnectionState.waiting:
                          //           return Center(
                          //             child: CircularProgressIndicator(
                          //                 color: AppColors.primaryColor),
                          //           );
            
                          //         case ConnectionState.done:
            
                          //         default:
                          //           if (snapshot.hasError) {
                          //             return SnapErrorWidget();
                          //           } else if (snapshot.hasData) {
                          //             return Column(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.all(2.w),
                          //                   child: Card(
                          //                     elevation: 5,
                          //                     child: Container(
                          //                       height: 7.h,
                          //                       color: Colors.white,
                          //                       child: Padding(
                          //                         padding: EdgeInsets.only(
                          //                             left: 3.w, right: 3.w),
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             CircleAvatar(
                          //                               radius: 15.dp,
                          //                               backgroundColor:
                          //                                   AppColors.primaryColor,
                          //                               child: Center(
                          //                                 child: Icon(
                          //                                   Ionicons.text,
                          //                                   color: AppColors
                          //                                       .secondaryColor,
                          //                                   size: 14.dp,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               // color: Colors.red,
                          //                               width: 65.w,
                          //                               height: 5.h,
                          //                               child: SelectableText(
                          //                                 provider
                          //                                     .travel!.travelName,
                          //                                 style: TextStyle(
                          //                                     overflow: TextOverflow
                          //                                         .ellipsis,
                          //                                     fontSize: 18.dp,
                          //                                     color: AppColors
                          //                                         .primaryColor,
                          //                                     height: 1.2),
                          //                                 // textScaleFactor: 0.8,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.all(2.w),
                          //                   child: Card(
                          //                     elevation: 5,
                          //                     child: Container(
                          //                       height: 7.h,
                          //                       color: Colors.white,
                          //                       child: Padding(
                          //                         padding: EdgeInsets.only(
                          //                             left: 3.w, right: 3.w),
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             CircleAvatar(
                          //                               radius: 15.dp,
                          //                               backgroundColor:
                          //                                   AppColors.primaryColor,
                          //                               child: Center(
                          //                                 child: Icon(
                          //                                   Ionicons.time,
                          //                                   color: AppColors
                          //                                       .secondaryColor,
                          //                                   size: 14.dp,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               // color: Colors.red,
                          //                               width: 65.w,
                          //                               height: 5.h,
                          //                               child: SelectableText(
                          //                                 provider.travel!
                          //                                     .travelAppointment,
                          //                                 style: TextStyle(
                          //                                     overflow: TextOverflow
                          //                                         .ellipsis,
                          //                                     fontSize: 18.dp,
                          //                                     color: AppColors
                          //                                         .primaryColor,
                          //                                     height: 1.2),
                          //                                 // textScaleFactor: 0.8,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.all(2.w),
                          //                   child: Card(
                          //                     elevation: 5,
                          //                     child: Container(
                          //                       height: 7.h,
                          //                       color: Colors.white,
                          //                       child: Padding(
                          //                         padding: EdgeInsets.only(
                          //                             left: 3.w, right: 3.w),
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             CircleAvatar(
                          //                               radius: 15.dp,
                          //                               backgroundColor:
                          //                                   AppColors.primaryColor,
                          //                               child: Center(
                          //                                 child: Icon(
                          //                                   Ionicons.person,
                          //                                   color: AppColors
                          //                                       .secondaryColor,
                          //                                   size: 14.dp,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               // color: Colors.red,
                          //                               width: 65.w,
                          //                               height: 5.h,
                          //                               child: SelectableText(
                          //                                 provider.travel!.userName,
                          //                                 style: TextStyle(
                          //                                     overflow: TextOverflow
                          //                                         .ellipsis,
                          //                                     fontSize: 18.dp,
                          //                                     color: AppColors
                          //                                         .primaryColor,
                          //                                     height: 1.2),
                          //                                 // textScaleFactor: 0.8,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.all(2.w),
                          //                   child: Card(
                          //                       child: ExpansionTile(
                          //                           title: Text(
                          //                             'Description',
                          //                             style: TextStyle(
                          //                                 color: AppColors
                          //                                     .primaryColor,
                          //                                 fontSize: 18.dp,
                          //                                 fontFamily: 'Cairo'),
                          //                           ),
                          //                           children: [
                          //                         SizedBox(
                          //                             width: 100.w,
                          //                             height: 60.h,
                          //                             child: ListView(
                          //                                 scrollDirection:
                          //                                     Axis.vertical,
                          //                                 children: [
                          //                                   Padding(
                          //                                     padding:
                          //                                         EdgeInsets.all(
                          //                                             2.w),
                          //                                     child: ExpandableText(
                          //                                       provider.travel!
                          //                                           .travelDescription,
                          //                                       expandText:
                          //                                           'Show More',
                          //                                       collapseText:
                          //                                           'Show less',
                          //                                     ),
                          //                                   ),
                          //                                 ]))
                          //                       ])),
                          //                 ),
                          //               ],
                          //             );
                          //           } else {
                          //             return SnapErrorWidget();
                          //           }
                          //       }
                          //     }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Payment operation's code :",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 17.dp,
                                      fontFamily: 'Cairo',
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                // width: 85.w,
                                height: 11.h,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 1.w, right: 1.w),
                                      child: SizedBox(
                                        width: 90.w,
                                        child: TextFormField(
                                          controller: _codeController,
                                          cursorColor: AppColors.primaryColor,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "please enter vodafone cash operation's number";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DropdownButton<String>(
                                  // value: _selectedScheduleName,
                                  hint: Text("Go only"),
                                  items: <String>[
                                    'Go only',
                                    'Back only',
                                    'Both',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    provider.dropCheck(val!, travelId);
                                  },
                                  value: provider.selectedScheduleName,
                                ),
                              ],
                            ),
                          ),
                          provider.selectedSchedule == 0
                              ? Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        // decoration: BoxDecoration(
                                        //   gradient: const LinearGradient(
                                        //     colors: [
                                        //       Color(0xffDC1C13),
                                        //       Color(0xffEA4C46),
                                        //     ],
                                        //     begin: FractionalOffset(0.0, 0.0),
                                        //     end: FractionalOffset(0.0, 1.0),
                                        //     stops: [0.0, 1.0],
                                        //     tileMode: TileMode.clamp,
                                        //   ),
                                        // ),
                                        width: 100.w,
                                        height: 20.h,
                                        child:  FutureBuilder(
                                        future: provider.getDestGo(travelId),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColors
                                                            .primaryColor),
                                              );

                                            case ConnectionState.done:

                                            default:
                                              if (snapshot.hasError) {
                                                return SnapErrorWidget();
                                              } else if (snapshot.hasData) {
                                                return ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: provider
                                                        .destGoList.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return FutureBuilder(
                                                          future: provider
                                                              .fetchTimesGo(provider
                                                                  .destGoList[
                                                                      index]
                                                                  .destinationGoID),
                                                          builder:
                                                              (context, snaps) {
                                                            switch (snaps
                                                                .connectionState) {
                                                              case ConnectionState
                                                                  .waiting:
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                );

                                                              case ConnectionState
                                                                  .done:

                                                              default:
                                                                if (snaps
                                                                    .hasError) {
                                                                  return SnapErrorWidget();
                                                                } else if (snaps
                                                                    .hasData) {
                                                                  final data =
                                                                      snaps.data
                                                                          as TimeGo;

                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .all(0.5
                                                                            .w),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                        Card(
                                                                          child: Container(
                                                                            width: 60.w,
                                                                            height: 10.h,
                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.h)),
                                                                            child: Padding(
                                                                              padding:  EdgeInsets.all(1.w),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(provider.destGoList[index].destinationName!, style: TextStyle(fontSize: 14.dp, color: AppColors.primaryColor)),
                                                                                  Text(DateFormat('hh:mm').format(data.time), style: TextStyle(fontSize: 14.dp, color: AppColors.secondaryColor))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 8.w,
                                                                        ),
                                                                        ElevatedButton(
                                                                            onPressed: () {
                                                                                                        provider.selectedDestGoID =  provider
                                                                            .destGoList[
                                                                                index]
                                                                            .destinationGoID!;
                                                                                                                                                                                                                                                                               provider.selectedTimeGoID = data.timeGoId;
                                                                                 provider.selectedTimeGoID = data.timeGoId;



                                                                            },
                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)),
                                                                            child: Text(
                                                                              "Select",
                                                                              style: TextStyle(fontSize: 14.dp),
                                                                            ))
                                                                            ],
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SnapErrorWidget();
                                                                }
                                                            }
                                                          });
                                                    }));
                                                //  }     );
                                              } else {
                                                return SnapErrorWidget();
                                              }
                                          }
                                        }),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(1.w),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty.all(
                                                            Size(30.w, 7.h)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Theme.of(context)
                                                                .scaffoldBackgroundColor),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(3.h),
                                                            side: BorderSide(color: AppColors.primaryColor)))),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 18.dp,
                                                      color:
                                                          AppColors.primaryColor),
                                                ),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.all(1.w),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty.all(
                                                            Size(30.w, 7.h)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            AppColors.primaryColor),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    3.h),
                                                            side:
                                                                BorderSide(color: AppColors.primaryColor)))),
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    provider.editTraveler(
                                                        context,
                                                        _codeController.text,
                                                        travelId,
                                                        travelerId);
                                                  } else {}
                                                },
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      fontSize: 18.dp,
                                                      color: Colors.white),
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : provider.selectedSchedule == 1
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          height: 20.h,
                                          child: FutureBuilder(
                                        future: provider.getDestBack(travelId),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColors
                                                            .primaryColor),
                                              );

                                            case ConnectionState.done:

                                            default:
                                              if (snapshot.hasError) {
                                                return SnapErrorWidget();
                                              } else if (snapshot.hasData) {
                                                return 
                                                ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: provider
                                                        .destBackList.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return FutureBuilder(
                                                          future: provider
                                                              .fetchTimesBack(provider
                                                                  .destBackList[
                                                                      index]
                                                                  .destinationBackId),
                                                          builder:
                                                              (context, snaps) {
                                                            switch (snaps
                                                                .connectionState) {
                                                              case ConnectionState
                                                                  .waiting:
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                );

                                                              case ConnectionState
                                                                  .done:

                                                              default:
                                                                if (snaps
                                                                    .hasError) {
                                                                  return SnapErrorWidget();
                                                                } else if (snaps
                                                                    .hasData) {
                                                                  final data =
                                                                      snaps.data
                                                                          as TimeBack;

                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .all(0.5
                                                                            .w),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                        Card(
                                                                          child: Container(
                                                                            width: 60.w,
                                                                            height: 10.h,
                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.h)),
                                                                            child: Padding(
                                                                              padding:  EdgeInsets.all(1.w),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(provider.destBackList[index].destinationNameB!, style: TextStyle(fontSize: 14.dp, color: AppColors.primaryColor)),
                                                                                  Text(DateFormat('hh:mm').format(data.timeB), style: TextStyle(fontSize: 14.dp, color: AppColors.secondaryColor))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 8.w,
                                                                        ),
                                                                        ElevatedButton(
                                                                            onPressed: () {
                                                                                                        provider.selectedDestBackID =  provider
                                                                            .destBackList[
                                                                                index]
                                                                            .destinationBackID!;
                                                                                                    // provider.selectedTimeBackID = timeId;
                                                                                                    provider.selectedTimeBackID = data.timeBackId;


                                                                            },
                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)),
                                                                            child: Text(
                                                                              "Select",
                                                                              style: TextStyle(fontSize: 14.dp),
                                                                            ))
                                                                            ],
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SnapErrorWidget();
                                                                }
                                                            }
                                                          });
                                                    }));
                                                //  }     );
                                              } else {
                                                return SnapErrorWidget();
                                              }
                                          }
                                        }),      
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(1.w),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      minimumSize:
                                                          MaterialStateProperty.all(
                                                              Size(30.w, 7.h)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Theme.of(context)
                                                                  .scaffoldBackgroundColor),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(3.h),
                                                              side: BorderSide(color: AppColors.primaryColor)))),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 18.dp,
                                                        color:
                                                            AppColors.primaryColor),
                                                  ),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.all(1.w),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      minimumSize:
                                                          MaterialStateProperty.all(
                                                              Size(30.w, 7.h)),
                                                      backgroundColor: MaterialStateProperty.all(
                                                          AppColors.primaryColor),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      3.h),
                                                              side: BorderSide(
                                                                  color: AppColors.primaryColor)))),
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      provider.editTraveler(
                                                          context,
                                                          _codeController.text,
                                                          travelId,
                                                          travelerId);
                                                    } else {}
                                                  },
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        fontSize: 18.dp,
                                                        color: Colors.white),
                                                  ),
                                                ))
                                          ],
                                        )
                                      ],
                                    )
                                  : provider.selectedSchedule == 2
                                      ? Column(
                                          children: [
                                                                                    Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.w),
                                                child: Text("Destinations go :",
                                                    style: TextStyle(
                                                      fontSize: 17.dp,
                                                      fontFamily: 'Cairo',
                                                    )),
                                              )
                                            ]),
                                        SizedBox(
                                          // decoration: BoxDecoration(
                                          //   gradient: const LinearGradient(
                                          //     colors: [
                                          //       Color(0xffDC1C13),
                                          //       Color(0xffEA4C46),
                                          //     ],
                                          //     begin: FractionalOffset(0.0, 0.0),
                                          //     end: FractionalOffset(0.0, 1.0),
                                          //     stops: [0.0, 1.0],
                                          //     tileMode: TileMode.clamp,
                                          //   ),
                                          // ),
                                          width: 100.w,
                                          height: 15.h,
                                          child: 
 ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: provider
                                                        .destGoList.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return FutureBuilder(
                                                          future: provider
                                                              .fetchTimesGo(provider
                                                                  .destGoList[
                                                                      index]
                                                                  .destinationGoID),
                                                          builder:
                                                              (context, snaps) {
                                                            switch (snaps
                                                                .connectionState) {
                                                              case ConnectionState
                                                                  .waiting:
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                );

                                                              case ConnectionState
                                                                  .done:

                                                              default:
                                                                if (snaps
                                                                    .hasError) {
                                                                  return SnapErrorWidget();
                                                                } else if (snaps
                                                                    .hasData) {
                                                                  final data =
                                                                      snaps.data
                                                                          as TimeGo;

                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .all(0.5
                                                                            .w),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                        Card(
                                                                          child: Container(
                                                                            width: 60.w,
                                                                            height: 10.h,
                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.h)),
                                                                            child: Padding(
                                                                              padding:  EdgeInsets.all(1.w),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(provider.destGoList[index].destinationName!, style: TextStyle(fontSize: 14.dp, color: AppColors.primaryColor)),
                                                                                  Text(DateFormat('hh:mm').format(data.time), style: TextStyle(fontSize: 14.dp, color: AppColors.secondaryColor))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 8.w,
                                                                        ),
                                                                        ElevatedButton(
                                                                            onPressed: () {
                                                                                                        provider.selectedDestGoID =  provider
                                                                            .destGoList[
                                                                                index]
                                                                            .destinationGoID!;
                                                                                                                                                                                provider.selectedTimeGoID = data.timeGoId;


                                                                            },
                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)),
                                                                            child: Text(
                                                                              "Select",
                                                                              style: TextStyle(fontSize: 14.dp),
                                                                            ))
                                                                            ],
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SnapErrorWidget();
                                                                }
                                                            }
                                                          });
                                                    }))                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.w),
                                                child:
                                                    Text("Destinations Back :",
                                                        style: TextStyle(
                                                          fontSize: 17.dp,
                                                          fontFamily: 'Cairo',
                                                        )),
                                              )
                                            ]),
                                        FutureBuilder(
                                            future:
                                                provider.getDestBack(travelId),
                                            builder: (context, snapshot) {
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.waiting:
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: AppColors
                                                                .primaryColor),
                                                  );

                                                case ConnectionState.done:

                                                default:
                                                  if (snapshot.hasError) {
                                                    return SnapErrorWidget();
                                                  } else if (snapshot.hasData) {
                                                    return SizedBox(
                                                      width: 100.w,
                                                      height: 20.h,
                                                      child:                                                ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: provider
                                                        .destBackList.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return FutureBuilder(
                                                          future: provider
                                                              .fetchTimesBack(provider
                                                                  .destBackList[
                                                                      index]
                                                                  .destinationBackId),
                                                          builder:
                                                              (context, snaps) {
                                                            switch (snaps
                                                                .connectionState) {
                                                              case ConnectionState
                                                                  .waiting:
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                );

                                                              case ConnectionState
                                                                  .done:

                                                              default:
                                                                if (snaps
                                                                    .hasError) {
                                                                  return SnapErrorWidget();
                                                                } else if (snaps
                                                                    .hasData) {
                                                                  final data =
                                                                      snaps.data
                                                                          as TimeBack;

                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .all(0.5
                                                                            .w),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                        Card(
                                                                          child: Container(
                                                                            width: 60.w,
                                                                            height: 10.h,
                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.h)),
                                                                            child: Padding(
                                                                              padding:  EdgeInsets.all(1.w),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(provider.destBackList[index].destinationNameB!, style: TextStyle(fontSize: 14.dp, color: AppColors.primaryColor)),
                                                                                  Text(DateFormat('hh:mm').format(data.timeB), style: TextStyle(fontSize: 14.dp, color: AppColors.secondaryColor))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 8.w,
                                                                        ),
                                                                        ElevatedButton(
                                                                            onPressed: () {
                                                                              
                                                                                                        provider.selectedDestBackID =  provider
                                                                            .destBackList[
                                                                                index]
                                                                            .destinationBackId!;
                                                                                                    provider.selectedTimeBackID = data.timeBackId;


                                                                            },
                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)),
                                                                            child: Text(
                                                                              "Select",
                                                                              style: TextStyle(fontSize: 14.dp),
                                                                            ))
                                                                            ],
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SnapErrorWidget();
                                                                }
                                                            }
                                                          });
                                                    }))

                                                    );
                                                  } else {
                                                    return SnapErrorWidget();
                                                  }
                                              }
                                            }),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(1.w),
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          minimumSize:
                                                              MaterialStateProperty.all(
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
                                                                          3.h),
                                                                  side: BorderSide(color: AppColors.primaryColor)))),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 18.dp,
                                                            color: AppColors
                                                                .primaryColor),
                                                      ),
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.all(1.w),
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          minimumSize:
                                                              MaterialStateProperty.all(
                                                                  Size(30.w, 7.h)),
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  AppColors
                                                                      .primaryColor),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          3.h),
                                                                  side: BorderSide(color: AppColors.primaryColor)))),
                                                      onPressed: () {
                                                        if (formKey.currentState!
                                                            .validate()) {
                                                          provider.editTraveler(
                                                              context,
                                                              _codeController.text,
                                                              travelId,
                                                              travelerId);
                                                        } else {}
                                                      },
                                                      child: Text(
                                                        "Confirm",
                                                        style: TextStyle(
                                                            fontSize: 18.dp,
                                                            color: Colors.white),
                                                      ),
                                                    ))
                                              ],
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(1.w),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      minimumSize:
                                                          MaterialStateProperty.all(
                                                              Size(30.w, 7.h)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Theme.of(context)
                                                                  .scaffoldBackgroundColor),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(3.h),
                                                              side: BorderSide(color: AppColors.primaryColor)))),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 18.dp,
                                                        color:
                                                            AppColors.primaryColor),
                                                  ),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.all(1.w),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      minimumSize:
                                                          MaterialStateProperty.all(
                                                              Size(30.w, 7.h)),
                                                      backgroundColor: MaterialStateProperty.all(
                                                          AppColors.primaryColor),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      3.h),
                                                              side: BorderSide(
                                                                  color: AppColors.primaryColor)))),
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      provider.editTraveler(
                                                          context,
                                                          _codeController.text,
                                                          travelId,
                                                          travelerId);
                                                    } else {}
                                                  },
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        fontSize: 18.dp,
                                                        color: Colors.white),
                                                  ),
                                                ))
                                          ],
                                        )
                        ]),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
