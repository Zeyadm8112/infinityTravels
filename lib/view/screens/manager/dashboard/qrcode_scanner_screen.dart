import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:bus/view_model/qrcode_scanner_view_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrcodeScannerScreen extends StatefulWidget {
  const QrcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrcodeScannerScreen> createState() => _QrcodeScannerScreenState();
}

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class _QrcodeScannerScreenState extends State<QrcodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;
  var qrCodeResult = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
//   @override
//   void initState() async{
// PermissionStatus status = await _getCameraPermission();

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
        final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String travelId = arg['id'].toString();
    String goBool = arg['go'];
    final provider = Provider.of<QrcodeScannerViewModel>(context);
        //  provider.travelId=travelId;

                            if (provider.state == ScanState.notFound) {
                              WidgetsBinding.instance.addPostFrameCallback((_){

      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: 'User not Subscribed',
          loopAnimation: true);
provider.state=ScanState.intial;

});

    } else if (provider.state == ScanState.found) {
      WidgetsBinding.instance.addPostFrameCallback((_){

      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'User Found',
          autoCloseDuration: Duration(seconds: 3),
          loopAnimation: true);
provider.state=ScanState.intial;

});
    } else if (provider.state == ScanState.unknown) {
      WidgetsBinding.instance.addPostFrameCallback((_){

      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: 'Something went wrong,please try agian later ',
          loopAnimation: true);
provider.state=ScanState.intial;

});

    }


    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Scan',
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 25.dp),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      body: Container(
        // padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Lottie.asset(
              'assets/images/qrscanner.json',
              width: 100.w,
              height: 50.h
            ),
            // Text(
            //   "Result",
            //   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 15.dp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding:  EdgeInsets.all(0.5.w),
              child: FlatButton(
                // padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  //  BarcodeScanner.scan();

                  var codeSanner =
                      await BarcodeScanner.scan(options: ScanOptions());
                  qrCodeResult = codeSanner.rawContent;
provider.checkTraveler(qrCodeResult, travelId, goBool);
                  // provider.checkUser(qrCodeResult);  


                  //  codeSanner=codeSanner.toString();

                  //  .toString();    //barcode scnner
/////                // try{
                  //   BarcodeScanner.scan()    this method is used to scan the QR code
                  // }catch (e){
                  //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                  //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                  // }
                },
                child: Text(
                  "Open Scanner",
                  style:
                      TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );

    // return SafeArea(
    //     child: Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //     Expanded(
    //       flex: 5,
    //       child:
    //        QRView(
    //         key: qrKey,
    //       onQRViewCreated:_onQrViewCreated ,
    //       )
    //       ),
    //       Expanded(
    //         flex: 1,
    //         child: Center(
    //           child: (result != null)?Text("Barcode Type : ${describeEnum(result!.format)}Data : ${result!.code}") : const Text("error"),
    //         ))
    //     ],
    //   ),
    // ));
  }
  //  Widget _buildButton({VoidCallback? onTap, required String text, Color? color}) {
  //   return
  //   Padding(
  //     padding: const EdgeInsets.only(bottom: 10.0),
  //     child: MaterialButton(
  //       color: color,
  //       minWidth: double.infinity,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //       onPressed: onTap,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 15.0),
  //         child: Text(
  //           text,
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget coolAlertZ(BuildContext context){
  //   return CoolAlert.show(context: context, type: type)

  // }
  //  bool _isFlashOn(String current) {
  //   return flashOn == current;
  // }

  // bool _isBackCamera(String current) {
  //   return backCamera == current;
  // }

// @override
// void reassemble() {
//     super.reassemble();
// if(Platform.isAndroid){
//   controller!.pauseCamera();
// }else if(Platform.isIOS){
//   controller!.resumeCamera();
// }
//   }
//   _onQrViewCreated(QRViewController controller){
//     controller.scannedDataStream.listen((scanData) {
//       setState((){
//         result=scanData;
//       });
//     });

//   }
//   @override
//   void dispose() {
// controller?.dispose();
//     super.dispose();
//   }
// //   Future<PermissionStatus> _getCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//         final result = await Permission.camera.request();
//         return result;
//     } else {
//       return status;
//     }
// }
}
