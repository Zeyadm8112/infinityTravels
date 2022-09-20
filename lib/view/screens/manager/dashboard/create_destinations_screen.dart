import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/consts/constants.dart';
import 'package:bus/main.dart';
import 'package:bus/view_model/create_destinations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../widgets/error_widget.dart';

class CreateDestinations extends StatelessWidget {
  const CreateDestinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double mWidth = MediaQuery.of(context).size.width;
    // double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<CreateDestinationsViewModel>(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int travelId = arg['id'];
    provider.travelId = travelId;
    // provider.getAllDestGo();
        if (provider.state == CreateDestinationsScreenState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 6))
          .show(context);
          provider.state=CreateDestinationsScreenState.loaded;
    } else     if (provider.state == CreateDestinationsScreenState.created) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
          provider.state=CreateDestinationsScreenState.loaded;
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add destinations"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(1.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Add Destination to go",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.dp,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Ionicons.arrow_forward,
                    size: 16.dp,
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding:  EdgeInsets.all(0.05.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 67.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.h)),
                      child: Padding(
                padding:  EdgeInsets.all(0.05.w),
                        child: TextFormField(
                          controller: provider.destGoTextController,
                          decoration: InputDecoration(
                              hintText: "Destinations",
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.7)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider.addDestGo();
                      },
                      child: Text("Save"),
                      // style: ButtonStyle(

                      // ),
                    )
                  ],
                ),
              ),
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
                                  itemCount: provider.destGoList!.length,
                                  itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              width: 67.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(2.h)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(provider.destGoList![index].destinationName),
                                  ),
                                ],
                              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Go & back ?",
                        style: TextStyle(fontSize: 17.dp)),
                    Switch.adaptive(
                        splashRadius: 18.dp,
                        value: provider.showBackDest,
                        onChanged: (val) {
                          provider.checkSwitchBool(val);
                        }),
                  ],
                ),
              ),
                            provider.showBackDest==false?

              SizedBox(
                height: 30.h,
              ):Container(),
              provider.showBackDest
                  ? Column(
                      children: [
              SizedBox(
                height: 1.h,
              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Add Destination to back",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.dp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Ionicons.arrow_back,
                              size:19.dp,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 67.w,
                                height: 12.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(2.h)),
                                child: Padding(
                padding:  EdgeInsets.all(0.05.w),
                                  child: TextFormField(
                                    controller: provider.destOffTextController,
                                    decoration: InputDecoration(
                                        hintText: "Destinations",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(.7)),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  provider.addDestOff();
                                },
                                child: Text("Save"),
                                // style: ButtonStyle(

                                // ),
                              )
                            ],
                          ),
                        ),
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
                                    itemCount: provider.destBackList!.length,
                                    itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    width: 67.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            2.h)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              provider.destBackList![index].destinationNameB),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                    }));
                              } else {
                                return SnapErrorWidget();
                              }
                          }
                        }),
                      ),
                    ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                padding:  EdgeInsets.all(2.w),
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
                padding:  EdgeInsets.all(2.w),
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
                                                  BorderRadius.circular(
                                                      1.h),
                                              side: BorderSide(
                                                  color: Colors.blue)))),
                                  onPressed: () {
                                    sharedPref!.setInt('id', travelId);
                                    Navigator.pushNamed(
                                        context, '/CreateTimesScreen',
                                        arguments: {'id': travelId});
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize:16.dp,
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
                padding:  EdgeInsets.all(0.05.w),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                          Size(30.w, 7.h)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              1.h),
                                          side:
                                              BorderSide(color: Colors.blue)))),
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
                padding:  EdgeInsets.all(0.05.w),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                          Size(30.w, 7.h)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              1.h),
                                          side:
                                              BorderSide(color: Colors.blue)))),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/CreateTimesScreen',
                                    arguments: {'id': travelId});

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
            ])),
      ),
    ));
  }
}
