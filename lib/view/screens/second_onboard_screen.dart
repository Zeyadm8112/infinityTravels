import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class SecondOnBoardScreen extends StatefulWidget {
  const SecondOnBoardScreen({Key? key}) : super(key: key);

  @override
  State<SecondOnBoardScreen> createState() => _SecondOnBoardScreenState();
}

class _SecondOnBoardScreenState extends State<SecondOnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    double _angle = 0;
    return Scaffold(
      backgroundColor:       Color(0xff9b111e),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: mHeight * 0.15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
//                 decoration: BoxDecoration(            color: Colors.blue,
//  ),
                  transform: Matrix4.rotationZ(_angle),
                  alignment: FractionalOffset.center,
                  duration: Duration(milliseconds: 500),
                  width: mWidth,
                  height: mHeight * 0.4,
                  child: Lottie.asset('assets/images/money.json')),
            ],
          ),
          Container(
            alignment: Alignment.center,
            // color:Colors.green,
              width: mWidth * 0.8,
              height: mHeight * 0.25,
              child: Text(
                "It's fast, it's Safe, it's the Least cost.",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontSize: mHeight * 0.035,fontFamily:'Amiri' ,),
              ))
        ],
      ),
    );
  }
}
