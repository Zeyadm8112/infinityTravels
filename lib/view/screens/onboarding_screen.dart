import 'package:animated_onboarding_ns/animated_onboarding_ns.dart';
import 'package:bus/view/screens/first_onboard_screen.dart';
import 'package:bus/view/screens/second_onboard_screen.dart';
import 'package:bus/view/screens/third_onboard_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../consts/app_colors.dart';
import '../../view_model/onboarding_view_model.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final _pages = [
// OnboardingPage(color: Colors.red, child: FirstOnBoardScreen())
// ,OnboardingPage(color: Colors.blue, child: SecondOnBoardScreen())
// ,OnboardingPage(color: Colors.green, child: ThirdOnBoardScreen())

      FirstOnBoardScreen(),
      SecondOnBoardScreen(),
      ThirdOnBoardScreen(),
    ];
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<OnBoardingViewModel>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
            controller: _controller,
            onPageChanged: (value) {
              provider.changeScreenIndex(value);
            },
            children: myData
                .map((item) => Container(
                      color: AppColors.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(3.w),
                            child: Center(
                              child: Column(children: [
                                Container(
                                  // color: Colors.red,
                                    width: 90.w,
                                    height: 45.h,
                                    child: Lottie.asset(item.imageurl)),
                                // SizedBox(
                                //   height: 2.h,
                                // ),
                                SizedBox(
                                  width: 90.w,
                                  height: 20.h,
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.dp,
                                        fontFamily: 'Cairo'),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height: 1.h),
                        ],
                      ),
                    ))
                .toList()),
        provider.currentIndex == 2
            ? Positioned(
                top: 80.h,
                left: 24.w,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/LoginScreen');
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.dp,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        color: AppColors.secondaryColor,
                        width: 1.w,
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/SignUpScreen');
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 15.dp,
                              fontFamily: 'Cairo'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Positioned(
                top: 80.h,
                left: 24.w,
                child: SizedBox(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _controller.previousPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 15.dp,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        color: Colors.white,
                        width: 1.w,
                        height: 3.h,
                      ),
                      SizedBox(width: 10.w),
                      TextButton(
                        onPressed: () {
                          _controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.dp,
                              fontFamily: 'Cairo'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
        Positioned(
          top: 90.h,
          left: 2.w,
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
                spacing: 4,
                expansionFactor: 2,
                dotWidth: 15.dp,
                activeDotColor: Colors.white,
                dotColor:AppColors.secondaryColor ),
          ),
        ),
        provider.currentIndex != 0
            ? Positioned(
                top: 0.5.h,
                right: 0.1.w,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/LoginScreen');
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.dp,
                        fontFamily: 'Cairo'),
                  ),
                ),
              )
            : Container(),
      ]),
    ));
  }

  buttonsRow(double mWidth, double mHeight, int? currentIndex) {
    int? index;
    currentIndex == null ? index = 0 : index == currentIndex;
    if (index == 2) {
      return Positioned(
        top: mHeight * 0.8,
        left: mWidth * 0.33,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _controller.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              },
              child: Text(
                "Log in",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: mHeight * 0.024,
                    fontFamily: 'Cairo'),
              ),
            ),
            Container(
              color: Colors.white,
              width: mWidth * 0.005,
              height: mHeight * 0.03,
            ),
            TextButton(
              onPressed: () {
                _controller.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              },
              child: Text(
                "Register",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: mHeight * 0.024,
                    fontFamily: 'Cairo'),
              ),
            )
          ],
        ),
      );
    } else {
      return Positioned(
        top: mHeight * 0.8,
        left: mWidth * 0.33,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _controller.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              },
              child: Text(
                "Back",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: mHeight * 0.024,
                    fontFamily: 'Cairo'),
              ),
            ),
            Container(
              color: Colors.white,
              width: mWidth * 0.005,
              height: mHeight * 0.03,
            ),
            TextButton(
              onPressed: () {
                _controller.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              },
              child: Text(
                "Next",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: mHeight * 0.024,
                    fontFamily: 'Cairo'),
              ),
            )
          ],
        ),
      );
    }
  }
}

class Data {
  final String title;
  final String imageurl;

  Data({
    required this.title,
    required this.imageurl,
  });
}

final List<Data> myData = [
  Data(
    title:
        "Our primary function is to promote an affordable, integrated, safe, responsive and sustainable land transport system ",
    imageurl: "assets/images/bus.json",
  ),
  Data(
    title: "It's fast, it's Safe, it's the Least cost.",
    imageurl: "assets/images/money.json",
  ),
  Data(
    title: "Your problem, our aim. Call us now for instant customer service.",
    imageurl: "assets/images/support.json",
  )
];
