import 'package:bus/main.dart';
import 'package:bus/view_model/view_all_travels_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_colors.dart';
import '../../../widgets/error_widget.dart';

class AllTravelsForEdit extends StatefulWidget {
  const AllTravelsForEdit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_AllTravelsForEditState();
}


class _AllTravelsForEditState extends State<AllTravelsForEdit>{

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<ViewAllTravelViewModel>(context);
    // Future.delayed(Duration.zero, () {
    //   //your code goes here

    //   provider.assign();
    // });

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "All Travels",
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: mHeight * 0.04),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: RefreshIndicator(
          onRefresh: ()async=> setState((){}),
          child: Column(
            children: [
              SizedBox(
                height: mHeight * 0.025,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: mHeight,
                  child: FutureBuilder(
                      future: provider.fetchAllTravles(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryColor),
                            );
        
                          case ConnectionState.done:
        
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("error"),
                              );
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: provider.travels!.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: SizedBox(
                                      child: Card(
                                        shadowColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1.h)),
                                        elevation: 10,
                                        child: Container(
                                          width: 85.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1.h),
                                            // gradient: const LinearGradient(
                                            //   colors: [
                                            //     const Color(0xffDC1C13),
                                            //     const Color(0xffEA4C46),
                                            //   ],
                                            //   begin: const FractionalOffset(0.0, 0.0),
                                            //   end: const FractionalOffset(1.0, 0.0),
                                            //   stops: [0.0, 1.0],
                                            //   tileMode: TileMode.clamp,
                                            // ),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  // Image.asset('assets/images/red1.jpg'),
                                                  Lottie.asset(
                                                      "assets/images/location3.json",
                                                      width: 20.w),
                                                  SizedBox(
                                                      width: 40.w,
                                                      height: 4.h,
                                                      child: Center(
                                                          child: SelectableText(
                                                        provider.travels![index]
                                                            .travelName,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'RaleWay',
                                                            fontSize: 18.dp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ))),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.w),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Divider(),
        
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  mWidth *
                                                                      0.01),
                                                          child: SizedBox(
                                                            width: mWidth,
                                                            height: 3.h,
                                                            child: Row(
                                                              children: [
                                                                SelectableText(
                                                                  "Appointment:",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'RobotoCondensed',
                                                                      fontSize:
                                                                          14.dp,
                                                                      color: Colors
                                                                          .black,
                                                                      height:
                                                                          1.2),
                                                                  // textScaleFactor: 0.8,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                SelectableText(
                                                                  provider
                                                                      .travels![
                                                                          index]
                                                                      .travelAppointment,
        
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'RobotoCondensed',
                                                                      fontSize:
                                                                          13.dp,
                                                                      color: Colors
                                                                          .grey,
                                                                      height:
                                                                          1.2),
                                                                  // textScaleFactor: 0.8,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                        FutureBuilder(
                                                          future:
                                                              provider.getTime(
                                                            provider
                                                                .travels![index]
                                                                .travelId
                                                                .toString(),
                                                          ),
                                                          builder: ((context,
                                                              snaps) {
                                                            switch (snaps
                                                                .connectionState) {
                                                              case ConnectionState
                                                                  .waiting:
                                                                return Center(
                                                                    child: Text(
                                                                        'Loading..',
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .dp,
                                                                            color: AppColors
                                                                                .secondaryColor,
                                                                            fontFamily:
                                                                                'RaleWay')));
        
                                                              case ConnectionState
                                                                  .done:
        
                                                              default:
                                                                if (snaps
                                                                    .hasError) {
                                                                  return SnapErrorWidget();
                                                                } else if (snaps
                                                                    .hasData) {
                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .all(mWidth *
                                                                            0.01),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          mWidth,
                                                                      height: 3.h,
                                                                      child: Row(
                                                                        children: [
                                                                          SelectableText(
                                                                            "Date:",
                                                                            style: TextStyle(
                                                                                fontFamily: 'RobotoCondensed',
                                                                                fontSize: 14.dp,
                                                                                color: Colors.black,
                                                                                height: 1.2),
                                                                            // textScaleFactor: 0.8,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                          Text(
  snaps.data.toString(),
        
                                                                            style: TextStyle(
                                                                                fontFamily: 'RobotoCondensed',
                                                                                fontSize: 13.dp,
                                                                                color: Colors.grey,
                                                                                height: 1.2),
                                                                            // textScaleFactor: 0.8,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SnapErrorWidget();
                                                                }
                                                            }
                                                        }),
                                                      ) // Padding(
                                                    ]),
                                              ),
                                                                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .white)),
                                                              onPressed: () {
                                                                showDialog<
                                                                    void>(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false, // user must tap button!
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Delete '),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            ListBody(
                                                                          children: const <
                                                                              Widget>[
                                                                            Text('Are you sure you want do delete this travel?'),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              const Text('No'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Yes'),
                                                                          onPressed:
                                                                              () {
                                  provider.deleteTravel(provider.travels![index].travelId);
                          
        setState(() {
          
        });                                                                                                                                                      Navigator.of(context).pop();
        
                                                                            // provider.deleteDestBack(
                                                                            //     provider
                                                                            //         .destBackList[
                                                                            //             index]
                                                                            //         .destinationBackId);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontFamily:
                                                                        'Cairo'),
                                                              )),
                                                          SizedBox(
                                                            width:
                                                                mWidth * 0.01,
                                                          ),
                                                          ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          AppColors
                                                                              .primaryColor)),
                                                              onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/EditTravelScreen',
                                              arguments: {
                                                'id': provider
                                                    .travels![index].travelId,
                                                'name': provider
                                                    .travels![index].travelName
                                              });
                                                              },
                                                              child: Text(
                                                                  'Edit',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Cairo'))),
                                                        ],
                                                      )
        
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            } else {
                              return Text("noData");
                            }
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
