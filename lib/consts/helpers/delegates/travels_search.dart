import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../app_colors.dart';
class TravelsSearchDelegate extends SearchDelegate {
List list;

TravelsSearchDelegate({required this.mHeight,required this.list});
double mHeight;
  List searchedTravels = [];


  // SubjectController controller = Get.put(SubjectController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    
 return [    IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear,color: AppColors.primaryColor,))
  ]; 
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back,color: AppColors.primaryColor,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // searchedSubject = controller.subjectsList
       searchedTravels=list
        .where(
            (e) => e.travelName.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    if (query == "") {
      return Center(child: Text("Find Travel",style: TextStyle(fontFamily: "Cairo",color:AppColors.secondaryColor,fontSize: 14.dp),));
    
  
    } else {
                return    SizedBox(
                  height: 100.h ,
                  child: ListView.builder(
                                itemCount: searchedTravels.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: SizedBox(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/TripInfo',
                                              arguments: {
                                                'id':searchedTravels[index]
                                                    .travelId
                                              });
                                          sharedPref!.setInt(
                                              'id',
                                             searchedTravels[index]
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
                                                          searchedTravels[
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
                                                                .all(1.w
                                                                    ),
                                                            child:
                                                                SizedBox(
                                                              width:
                                                                  100.w,
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
                                                                    searchedTravels[index]
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
                                                        // FutureBuilder(
                                                        //   future: provider
                                                        //       .getDestiantions(
                                                        //     searchedTravels[
                                                        //             index]
                                                        //         .travelId,
                                                        //   ),
                                                        //   builder: ((context,
                                                        //       snapshot) {
                                                        //     switch (snapshot
                                                        //         .connectionState) {
                                                        //       case ConnectionState
                                                        //           .waiting:
                                                        //         return Center(
                                                        //             child: Text(
                                                        //                 'Loading..',
                                                        //                 style: TextStyle(fontSize: 12.dp, color: AppColors.secondaryColor, fontFamily: 'RaleWay')));

                                                        //       case ConnectionState
                                                        //           .done:

                                                        //       default:
                                                        //         if (snapshot
                                                        //             .hasError) {
                                                        //           return Center(
                                                        //               child:
                                                        //                   Text('error', style: TextStyle(fontSize: 12.dp, color: AppColors.secondaryColor, fontFamily: 'RaleWay')));
                                                        //         } else if (snapshot
                                                        //             .hasData) {
                                                        //           return Padding(
                                                        //             padding:
                                                        //                 EdgeInsets.all(mWidth * 0.01),
                                                        //             child:
                                                        //                 SizedBox(
                                                        //               width:
                                                        //                   mWidth,
                                                        //               height:
                                                        //                   3.h,
                                                        //               child:
                                                        //                   Row(
                                                        //                 children: [
                                                        //                   SelectableText(
                                                        //                     "Date:",
                                                        //                     style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 14.dp, color: Colors.black, height: 1.2),
                                                        //                     // textScaleFactor: 0.8,
                                                        //                     textAlign: TextAlign.center,
                                                        //                   ),
                                                        //                   SelectableText(
                                                        //                    searchedTravels[index].travelDescription,

                                                        //                     style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 13.dp, color: Colors.grey, height: 1.2),
                                                        //                     // textScaleFactor: 0.8,
                                                        //                     textAlign: TextAlign.center,
                                                        //                   ),
                                                        //                 ],
                                                        //               ),
                                                        //             ),
                                                        //           );
                                                        //         } else {
                                                        //           return Center(
                                                        //               child:
                                                        //                   Text('ُerror', style: TextStyle(fontSize: 12.dp, color: AppColors.secondaryColor, fontFamily: 'RaleWay')));
                                                        //         }
                                                        //     }
                                                        //   }),
                                                        // ) // Padding(
                                                  
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
                )

                );
    }
  }
}
