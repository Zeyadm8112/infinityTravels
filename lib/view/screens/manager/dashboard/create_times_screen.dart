import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/view/widgets/error_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../view_model/create_times_view_model.dart';

class CreateTimesScreen extends StatefulWidget {
  const CreateTimesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTimesScreenState();
}

class _CreateTimesScreenState extends State<CreateTimesScreen> {
  // @override
  // void initState() {
  //   var provider = Provider.of<CreateTimesViewModel>(context, listen: false);

  //   provider.assign(sharedPref!.getInt('id')!);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // double mWidth = MediaQuery.of(context).size.width;
    // double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<CreateTimesViewModel>(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int travelId = arg['id'];
    provider.travelId = travelId;
    if (provider.state == CreateTimesScreenState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 6))
          .show(context);
      provider.state = CreateTimesScreenState.loaded;
    } else if (provider.state == CreateTimesScreenState.created) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
      provider.state = CreateTimesScreenState.loaded;
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add times"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19.dp,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            provider.datePicker(context);
                          },
                          child: Text("Set Date",style: TextStyle(fontSize: 14.dp),))
                    ],
                  ),
                  Center(
                    child:
                        provider.date == null ? Text("") : Text(provider.date!),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Add Times to go",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.dp,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Ionicons.time_outline,
                        size: 17.dp,
                      )
                    ],
                  ),
                  // Center(
                  //   child: Text(provider.travelId.toString()),
                  // ),
                  SizedBox(
                    width: 100.w,
                    height: 30.h,
                    child: FutureBuilder(
                      future: provider.getDestGo(),
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
return SnapErrorWidget();
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: provider.destGoList.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding:  EdgeInsets.all(0.05.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60.w,
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      2.h)),
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
                                          ElevatedButton(
                                            child: Text("Set time"),
                                            onPressed: () async {
                                              provider.timePickerGO(
                                                  context,
                                                  provider.destGoList[index]
                                                      .destinationGoID);

                                              // provider.deleteDestGo(provider
                                              //     .destBackList![index]
                                              //     .destinationBackId);
                                            },
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
                ]),
                // provider.destBackList! == []
                //     ? Container()
                //     :
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Add Times to back",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.dp,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Ionicons.time_outline,
                          size: 17.dp,
                        )
                      ],
                    ),

                    // Center(
                    //   child: Text(provider.travelId.toString()),
                    // ),
                    SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: FutureBuilder(
                        future: provider.getDestBack(),
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
                                  child: Text("error"),
                                );
                              } else if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: provider.destBackList.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: 60.w,
                                                  height: 12.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.h)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(provider
                                                            .destBackList[index]
                                                            .destinationNameB),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            ElevatedButton(
                                              child: Text("Set time"),
                                              onPressed: () {
                                                provider.timePickerBack(
                                                    context,
                                                    provider.destBackList[index]
                                                        .destinationBackId);

                                                // provider.deleteDestGo(provider
                                                //     .destBackList![index]
                                                //     .destinationBackId);
                                              },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(1.w),
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
                                fontSize: 16.dp, color: Colors.blue),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(1.w),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  Size(30.w, 7.h)),
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
                                      if (sharedPref!.getString('roleName') == "Manger") {
          // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/MainScreen', (route) => true);
        }else if (sharedPref!.getString('roleName') == "Admin") {
          // ignore: use_build_context_synchronously
                                      Navigator.pushNamedAndRemoveUntil(
                                context, '/AdminDashBoardScreen', (route) => true);

        }

                            Navigator.pushNamedAndRemoveUntil(
                                context, '/MainScreen', (route) => true);

// Navigator.pop(context);
                            AnimatedSnackBar.material(
                                    "Travel created successfully",
                                    type: AnimatedSnackBarType.success,
                                    mobileSnackBarPosition:
                                        MobileSnackBarPosition.bottom,
                                    duration: const Duration(seconds: 3))
                                .show(context);
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize:16.dp, color: Colors.white),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
