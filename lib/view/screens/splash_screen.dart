import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bus/view/screens/manager/dashboard/admins_Screen.dart';
import 'package:bus/view/screens/manager/dashboard/dashboard.dart';
import 'package:bus/view/screens/onboarding_screen.dart';
import 'package:bus/view/screens/user/main_screen_user.dart';
import 'package:bus/view/screens/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../../main.dart';
import 'manager/dashboard/admin_dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    return SplashScreenView(
      backgroundColor: Colors.white,
      duration: 3000,
        // child: Image.asset('assets/images/backlogo.png'
        // // ,width: 50.w,height: 50.h
        // ,
        // fit: BoxFit,)
        imageSrc:'assets/images/backlogo.png',
        imageSize:260.dp.toInt(),
    
      // splashTransition: SplashTransition.slideTransition,
      navigateRoute: sharedPref!.getString('name') != null &&
              sharedPref!.getString('roleName') == 'User'
          ? MainScreenUser()
          : sharedPref!.getString('name') != null &&
                      sharedPref!.getString('roleName') == 'Manger' 
                 
              ? DashBoardScreen():
               sharedPref!.getString('name') != null &&
                      sharedPref!.getString('roleName') == 'Admin'?
                      AdminDashBoardScreen()
              : OnBoardingScreen(),
    );
  }
}
