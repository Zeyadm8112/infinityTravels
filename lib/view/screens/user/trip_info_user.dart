import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/constants.dart';
import '../../../view_model/edit_traveler_view_model.dart';
import '../../widgets/error_widget.dart';
import '../image_view_screen.dart';

class TripInfo extends StatefulWidget {
  const TripInfo({Key? key}) : super(key: key);

  @override
  State<TripInfo> createState() => _TripInfoState();
}

class _TripInfoState extends State<TripInfo> {
  @override
  Widget build(BuildContext context) {
        final arg = ModalRoute.of(context)!.settings.arguments as Map;

        int travelId = arg['id'];
    String travelName = arg['name'];
    var provider = Provider.of<EditTravelerViewModel>(context);

    return SafeArea(child:
     Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            travelName,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'BebasNeue',
                fontSize: 25.dp),
          ),
        ),
        body: SingleChildScrollView(child: Column(children: [


                          SizedBox(
                            width: 100.w,
                            height: 30.h,
                            child: FutureBuilder(
                              future: provider.getTravel(travelId),
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
                                      return Center(
                                          child: Text(
                                        "error ",
                                        style: TextStyle(
                                            fontSize: 15.dp,
                                            color: AppColors.secondaryColor,
                                            fontFamily: 'Cairo'),
                                      ));
                                    } else if (snapshot.hasData) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageViewScreen(
                                                            "$baseUrl/Content/IMG/${provider.travel!.imagePath}")));
                                          },
                                          child: Container(
                                            // color: Colors.red,
                                            width: 100.w,
                                            height: 30.h,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Image.network(
                                                "$baseUrl/Content/IMG/${provider.travel!.imagePath}",
                                                frameBuilder: (context,
                                                        child,
                                                        frame,
                                                        wasSynchronouslyLoaded) =>
                                                    child,
                                                loadingBuilder: ((context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                                errorBuilder:
                                                    (context, error, stackTrace) {
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
                                          ));
                                    } else {
                                      return SnapErrorWidget();
                                    }
                                }
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          FutureBuilder(
                              future: provider.fetchTravel(travelId),
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
                                      return SnapErrorWidget();
                                    } else if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          Padding(
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
                                                            Ionicons.text,
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
                                                          provider
                                                              .travel!.travelName,
                                                          style: TextStyle(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 18.dp,
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
                                          ),
                                          Padding(
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
                                                            Ionicons.time,
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
                                                          provider.travel!
                                                              .travelAppointment,
                                                          style: TextStyle(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 18.dp,
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
                                          ),
                                          Padding(
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
                                                          provider.travel!.userName,
                                                          style: TextStyle(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 18.dp,
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
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(2.w),
                                            child: Card(
                                                child: ExpansionTile(
                                                    title: Text(
                                                      'Description',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontSize: 18.dp,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                    children: [
                                                  SizedBox(
                                                      width: 100.w,
                                                      height: 60.h,
                                                      child: ListView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      2.w),
                                                              child: ExpandableText(
                                                                provider.travel!
                                                                    .travelDescription,
                                                                expandText:
                                                                    'Show More',
                                                                collapseText:
                                                                    'Show less',
                                                              ),
                                                            ),
                                                          ]))
                                                ])),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return SnapErrorWidget();
                                    }
                                }
                              }),


        ],)),
    )
    );
    
  }
}