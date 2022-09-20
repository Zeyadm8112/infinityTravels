import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../consts/app_colors.dart';

class SnapErrorWidget extends StatelessWidget {
  const SnapErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Please refresh the page', style: TextStyle(fontSize: 12.dp, color: AppColors.secondaryColor, fontFamily: 'RaleWay')));
  }
}
