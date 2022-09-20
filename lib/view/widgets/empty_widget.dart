import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';

import '../../consts/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:Column(children: [
Lottie.asset('assets/images/empty.json',width: 60.w,height: 60.h),
Text("This page is empty right now try agian later",style: TextStyle(color: AppColors.secondaryColor,fontSize: 15.dp,fontFamily: 'Cairo'),)

    ],));
  }
}