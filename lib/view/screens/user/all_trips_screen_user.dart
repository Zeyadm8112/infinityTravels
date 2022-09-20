import 'dart:async';
import 'dart:ui';

import 'package:animated_card/animated_card.dart';
import 'package:bus/consts/constants.dart';
import 'package:bus/consts/helpers/delegates/travels_search.dart';
import 'package:bus/main.dart';
import 'package:bus/view/screens/user/trip_info_user.dart';
import 'package:bus/view/widgets/anim_error_widget.dart';
import 'package:bus/view/widgets/drawer.dart';
import 'package:bus/view/widgets/empty_widget.dart';
import 'package:bus/view/widgets/menu_bar_widget.dart';
import 'package:bus/view/widgets/trips_card.dart';
import 'package:bus/view_model/view_all_travels_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/values.dart';
import '../../widgets/error_widget.dart';

class AllTripsScreenUser extends StatefulWidget {
  const AllTripsScreenUser({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AllTripsScreenUserState();
}

class _AllTripsScreenUserState extends State<AllTripsScreenUser>
     {
  // final Connectivity _connectivity = Connectivity();
  //  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // bool isConnected = true;

  // late Future<dynamic> dataFuture;
  // @override
  // void initState() {
  // _connectivitySubscription=  _connectivity.onConnectivityChanged.listen((event) {
  //     setState(() {
  //       if (event == ConnectivityResult.none) {
  //         isConnected = false;
  //       } else {
  //         isConnected = true;
  //       }
  //     });
  //     super.initState();
  //   });

    // provider.fetchAllTravles();
//   }
//   @override
//   void dispose() {
//  _connectivitySubscription.cancel();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<ViewAllTravelViewModel>(context);
    // provider.checkConnection();
    // if (provider.state == AllTripsScreenState.notConnected) {
    //   return Center(
    //     child: Text("no Internet"),
    //   );
    // }
    // else{

    return SafeArea(
        child: ZoomDrawer(
      menuBackgroundColor: Colors.white,
      menuScreen: MyDrawer(),
      mainScreen: Scaffold(
        appBar: AppBar(
          title: Text(
            'Infinity Travel',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'BebasNeue',
                fontSize: 25.dp),
          ),
          actions: [
            IconButton(
                onPressed: () {
            showSearch(context: context, delegate: TravelsSearchDelegate(mHeight: mHeight,list:provider.travels!));
                },
                icon: Icon(Icons.search)),
          ],
          leading:                          MenuWidget(AppColors.primaryColor),

        ),
        resizeToAvoidBottomInset: true,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              provider.fetchAllTravles();
            });
          },
          child:
          //  isConnected == false
          //     ? Center(
          //         child: Column(mainAxisSize: MainAxisSize.min,
          //             // crossAxisAlignment: CrossAxisAlignment.center,
          //             // mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               SizedBox(
          //                   height: 50.h,
          //                   width: 50.w,
          //                   child: Lottie.asset('assets/images/nowifi2.json')),
          //                         Text("Lost Wifi Connection",style:TextStyle(color: AppColors.secondaryColor,fontSize: 14.dp,fontFamily: 'Cairo'),),
          //             ]),
          //       )
          //     : 
              Column(
                  children: [
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: mHeight,
                        child: FutureBuilder(
                            future: provider.getTravels(),
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
                                    return ErrorAnimWidget();
                                  } else if (snapshot.hasData) {
                                  if(provider.travels!.isEmpty){
return EmptyWidget();

                                  }else{
                                    return ListView.builder(
                                      itemCount: provider.travels?.length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(3.w),
                                          child: SizedBox(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/TripScreen',
                                                    arguments: {
                                                      'id': provider
                                                          .travels![index]
                                                          .travelId
                                                          ,
                                                          'name': provider
                                                          .travels![index]
                                                          .travelName
                                                    });
                                                sharedPref!.setInt(
                                                    'id',
                                                    provider.travels![index]
                                                        .travelId);
                                              },
                                              child: Card(
                                                shadowColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.h)),
                                                elevation: 10,
                                                child: Container(
                                                  width: 85.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.h),
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
                                                                  child:
                                                                      SelectableText(
                                                                provider
                                                                    .travels![
                                                                        index]
                                                                    .travelName,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'RaleWay',
                                                                    fontSize:
                                                                        18.dp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(1.w),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Divider(),

                                                              SizedBox(
                                                                child: Padding(
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
                                                                          "Appointment:",
                                                                          style: TextStyle(
                                                                              fontFamily: 'RobotoCondensed',
                                                                              fontSize: 14.dp,
                                                                              color: Colors.black,
                                                                              height: 1.2),
                                                                          // textScaleFactor: 0.8,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        SelectableText(
                                                                          provider
                                                                              .travels![index]
                                                                              .travelAppointment,

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
                                                                ),
                                                              ),
                                                              FutureBuilder(
                                                                future: provider
                                                                    .fetchTime(
                                                                  provider
                                                                      .travels![
                                                                          index]
                                                                      .travelId.toString(),
                                                                ),
                                                                builder: ((context,
                                                                    snapshot) {
                                                                      final data= snapshot.data;
                                                                  switch (snapshot
                                                                      .connectionState) {
                                                                    case ConnectionState
                                                                        .waiting:
                                                                      return Center(
                                                                          child: Text(
                                                                              'Loading..',
                                                                              style: TextStyle(fontSize: 12.dp, color: AppColors.secondaryColor, fontFamily: 'RaleWay')));

                                                                    case ConnectionState
                                                                        .done:

                                                                    default:
                                                                      if (snapshot
                                                                          .hasError) {
                                                                        return Center(
                                                                            child:
                                                                                SnapErrorWidget());
                                                                      } else if (snapshot
                                                                          .hasData) {
                                                                        return Padding(
                                                                          padding:
                                                                              EdgeInsets.all(mWidth * 0.01),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                mWidth,
                                                                            height:
                                                                                3.h,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                SelectableText(
                                                                                  "Date:",
                                                                                  style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 14.dp, color: Colors.black, height: 1.2),
                                                                                  // textScaleFactor: 0.8,
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                                Text(
                                                                                  data?.toString()??'Loading..',

                                                                                  style: TextStyle(
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    fontFamily: 'RobotoCondensed', fontSize: 13.dp, color: Colors.grey, height: 1.2),
                                                                                  // textScaleFactor: 0.8,
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Center(
                                                                            child:
                                                                                Text('ُerror', style: TextStyle(fontSize: 12.dp, color: AppColors.secondaryColor, fontFamily: 'RaleWay')));
                                                                      }
                                                                  }
                                                                }),
                                                              ) // Padding(
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                   } } 
                                  else {
                                    return Text("noData");
                                  }
                              }
                            }),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    ));
  }
}

// }
