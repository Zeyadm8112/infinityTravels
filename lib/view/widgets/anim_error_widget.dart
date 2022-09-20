import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';

import '../../consts/app_colors.dart';

class ErrorAnimWidget extends StatelessWidget {
  const ErrorAnimWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:Column(children: [
Lottie.asset('assets/images/erorr.json',width: 60.w,height: 60.h),
Text("Something went wrong try agian later",style: TextStyle(color: AppColors.secondaryColor,fontSize: 15.dp,fontFamily: 'Cairo'),)

    ],));
  }
}