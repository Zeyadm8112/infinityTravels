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

class AllTravelsForScan extends StatelessWidget {
  const AllTravelsForScan({Key? key}) : super(key: key);

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
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/DestiantionsByTravel',
                                            arguments: {
                                              'id': provider
                                                  .travels![index].travelId,
                                              'name': provider
                                                  .travels![index].travelName
                                            });
                                        sharedPref!.setInt('id',
                                            provider.travels![index].travelId);
                                      },
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
            )
          ],
        ),
      ),
    );
  }
}
