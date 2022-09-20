import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ionicons/ionicons.dart';

import '../../consts/app_colors.dart';

class MenuWidget extends StatelessWidget {
Color color;

  MenuWidget(this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          ZoomDrawer.of(context)!.toggle();
        },
        icon: Icon(
          Ionicons.menu_outline,
          color: color,
          size: 4.5.h,
        ));
  }
}
