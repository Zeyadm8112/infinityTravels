import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ImageViewScreen extends StatelessWidget {
  String imageUrl;
  ImageViewScreen(this.imageUrl,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

body: Center(child: InteractiveViewer(
  maxScale: 1.5,
  child:                                Image.network(
    imageUrl,
    frameBuilder: (context, child, frame,
            wasSynchronouslyLoaded) =>
        child,
    loadingBuilder:
        ((context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Container();
      }
    }),
    errorBuilder: (context, error, stackTrace) {
      return SizedBox(
          width: 2.w,
          height: 1.h,
          child: Icon(Icons.error_outline,color: Colors.red,));
    },
  )),
)
    );
  }
}