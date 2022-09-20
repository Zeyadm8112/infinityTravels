import 'package:bus/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(.7),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height:2.h),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset('assets/images/infinity.jpg',)),
                  ),
                ),
                                SizedBox(height:2.h),

                Expanded(
                  flex:1,
                  child: Text(
                    
                              sharedPref!.getString('name')!,
                              textAlign: TextAlign.center,
                              overflow:TextOverflow.ellipsis,
                              style: TextStyle(
                    color: Colors.white, fontFamily: 'Rubik', fontSize: 16.dp),
                            ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(1.w),
            child: SizedBox(
              height: 51.h,
              child: ListView(children: [
                ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, '/ProfileScreen');
                    },
                    leading: Icon(Icons.person_outline, color: Colors.black),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: 18.dp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Cairo"),
                    )),
                ListTile(
                  leading: Icon(Icons.qr_code_2, color: Colors.black),
                  title: Text(
                    "Qrcode",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: mWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/QrcodeGenerateScreen');
                  },
                ),
                ListTile(
                  leading: Icon(Ionicons.information_circle_outline,
                      color: Colors.black),
                  title: Text(
                    "About",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: mWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  
                  leading: Icon(Icons.facebook,
                      color: Colors.black),
                  title: Text(
                    "Contact",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: mWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  onTap: () async{
                    if (await canLaunchUrl(Uri.parse('https://www.facebook.com/InfintySuezTravel')) ){
    // ignore: deprecated_member_use
    final bool nativeAppLaunchSucessed =await launch('https://www.facebook.com/InfintySuezTravel',forceSafariVC: false,universalLinksOnly: true,);
  if(!nativeAppLaunchSucessed){
// ignore: deprecated_member_use
await launch('https://www.facebook.com/InfintySuezTravel');
  };
  //                   if (await canLaunchUrl(Uri.parse('https://www.facebook.com/InfintySuezTravel')))
  // await launchUrl(Uri.parse('https://www.facebook.com/InfintySuezTravel'));
                    }}
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode_outlined,
                      color: Colors.black),
                  title: Text(
                    "Theme",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: mWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Ionicons.log_out_outline, color: Colors.black),
                  title: Text(
                    "Log out",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: mWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  onTap: () {
                    sharedPref!.remove('name');
                    sharedPref!.remove('roleName');
                    sharedPref!.remove('userID');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/LoginScreen', (Route<dynamic> route) => false);
                  },
                ),
              ]),
            ),
          ),
        ),
      ],
    ));
  }
}
