import 'package:bus/main.dart';
import 'package:bus/view_model/qrcode_generate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../consts/app_colors.dart';

class QrcodeGenerateScreen extends StatefulWidget {
  const QrcodeGenerateScreen({Key? key}) : super(key: key);

  @override
  State<QrcodeGenerateScreen> createState() => _QrcodeGenerateScreenState();
}

class _QrcodeGenerateScreenState extends State<QrcodeGenerateScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QrcodeGenerateViewModel>(context, listen: false);
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

//     var p=Provider.of<QrcodeGenerateViewModel>(context,listen: false);
// p.getQrcode();

    return SafeArea(
        child: Container(
            height: mWidth,
            width: mHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mHeight * 0.02),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.6),
                ],
                begin: const FractionalOffset(1.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 38.dp,
                          )),
                      Lottie.asset('assets/images/qrcode.json',
                          width: 10.w, height: 10.h),
                    ],
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Text(
                    sharedPref!.getString('name')!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.dp,
                        fontFamily: 'Cairo'),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  //  Center(
                  //           child: SizedBox(
                  //             width:50.w,
                  //             height: 30.h,
                  //             child: QrImage(
                  //               data: sharedPref!.getString('userID')!,
                  //             ),
                  //           ),
                  //  )
                  Center(
                      child:
                       Container(
                          width: 51.w,
                          height: 51.w,
                          color: Colors.white,
                          child: Center(
                            child: SizedBox(
                              width:50.w,
                              height: 30.h,
                              child: Center(
                                child: QrImage(
                                  data: sharedPref!.getString('userID')!,
                                ),
                              ),
                            ),
                          )
                          )
                          )
                ]))));
  }
}
