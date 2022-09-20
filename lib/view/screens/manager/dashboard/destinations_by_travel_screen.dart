import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_colors.dart';
import '../../../../view_model/create_destinations_view_model.dart';

class DestiantionsByTravel extends StatefulWidget {
  const DestiantionsByTravel({Key? key}) : super(key: key);

  @override
  State<DestiantionsByTravel> createState() => _DestiantionsByTravelState();
}

class _DestiantionsByTravelState extends State<DestiantionsByTravel> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int travelId = arg['id'];
    String travelName = arg['name'];
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<CreateDestinationsViewModel>(context);
    provider.travelId = travelId;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                travelName,
                style: TextStyle(fontFamily: 'BebasNeue', fontSize: 20.dp),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/QrcodeScannerScreen',
                        arguments: {'id': travelId, 'go': 'true'});
                  },
                                                                  style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size(30.w,
                                                              7.h)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                        Colors.blue),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  3.h),
                                                          side: BorderSide(color: Colors.blue)))),

                  child: Text(
                    "Scan GO",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/QrcodeScannerScreen',
                          arguments: {'id': travelId, 'go': 'false'});
                    },
                                                                  style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size(30.w,
                                                              7.h)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                        Colors.blue),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  3.h),
                                                          side: BorderSide(color: Colors.blue)))),

                    child: Text(
                      "Scan Back",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                )],
            ))));
  }
}
