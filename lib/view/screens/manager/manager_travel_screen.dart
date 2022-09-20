import 'dart:ui';

import 'package:animated_card/animated_card.dart';
import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:bus/view/screens/user/trip_info_user.dart';
import 'package:bus/view/widgets/drawer.dart';
import 'package:bus/view/widgets/menu_bar_widget.dart';
import 'package:bus/view/widgets/trips_card.dart';
import 'package:bus/view_model/manager_travels_view_model.dart';
import 'package:bus/view_model/view_all_travels_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../consts/values.dart';

class ManagerTravelsScreen extends StatefulWidget {
  const ManagerTravelsScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ManagerTravelsScreenState();
}

class _ManagerTravelsScreenState extends State<ManagerTravelsScreen>
    with SingleTickerProviderStateMixin {
  // late Future<dynamic> dataFuture;
  @override
  void initState() {
    var provider = Provider.of<ViewAllTravelViewModel>(context, listen: false);
    // provider.fetchAllTravles();
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<ManagerTravelsViewModel>(context);
    // provider.checkConnection();
    // if (provider.state == AllTripsScreenState.notConnected) {
    //   return Center(
    //     child: Text("no Internet"),
    //   );
    // }
    // else{

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Manager's Travels",
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: mHeight * 0.04),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            SizedBox(
              height: mHeight * 0.025,
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
                            child: CircularProgressIndicator(color: Colors.red),
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
                                  padding: EdgeInsets.all(mHeight * 0.02),
                                  child: SizedBox(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/TripScreen', arguments: {
                                          'id':
                                              provider.travels![index].travelId
                                        });
                                        sharedPref!.setInt('id',
                                            provider.travels![index].travelId);
                                      },
                                      child: Card(
                                        shadowColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                mHeight * 0.01)),
                                        elevation: 10,
                                        child: Container(
                                          width: mWidth * 0.85,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                mHeight * 0.02),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  // Image.asset('assets/images/red1.jpg'),
                                                  Lottie.asset(
                                                      "assets/images/location1.json",
                                                      width: mWidth * 0.2),
                                                  SizedBox(
                                                      width: mWidth * 0.3,
                                                      height: mHeight * 0.03,
                                                      child: Center(
                                                          child: SelectableText(
                                                        provider.travels![index]
                                                            .travelName,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'RaleWay',
                                                            fontSize:
                                                                mHeight * 0.03,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ))),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    mHeight * 0.01),
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
                                                            height:
                                                                mHeight * 0.03,
                                                            child: Row(
                                                              children: [
                                                                SelectableText(
                                                                  "Appointment:",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'RobotoCondensed',
                                                                      fontSize:
                                                                          mWidth *
                                                                              0.04,
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
                                                                          mWidth *
                                                                              0.04,
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
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  mWidth *
                                                                      0.01),
                                                          child: SizedBox(
                                                            width: mWidth,
                                                            height:
                                                                mHeight * 0.03,
                                                            child: Row(
                                                              children: [
                                                                SelectableText(
                                                                  "Description:",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'RobotoCondensed',
                                                                      fontSize:
                                                                          mWidth *
                                                                              0.04,
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
                                                                      .travelDescription,

                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'RobotoCondensed',
                                                                      fontSize:
                                                                          mWidth *
                                                                              0.04,
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

                                                      // Padding(
                                                    ]),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(right:mWidth * 0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white)),
                                                        onPressed: () {},
                                                        child: Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        )),
                                                    SizedBox(
                                                      width: mWidth * 0.02,
                                                    ),
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .red)),
                                                        onPressed: () {
                                                            Navigator.pushReplacementNamed(context, '/EditTravelScreen',
              arguments: {'id': provider.travels![index]
                                                            .travelId });
                                                        },
                                                        child: Text('Edit',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo'))),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}
    // }