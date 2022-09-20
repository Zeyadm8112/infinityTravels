import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class FirstOnBoardScreen extends StatefulWidget {
  const FirstOnBoardScreen({Key? key}) : super(key: key);

  @override
  State<FirstOnBoardScreen> createState() => _FirstOnBoardScreenState();
}

class _FirstOnBoardScreenState extends State<FirstOnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    double _angle = 0;
    return Scaffold(
      backgroundColor: Color(0xffb31b1b),
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
              SizedBox(
//                 decoration: BoxDecoration(            color: Colors.blue,
//  ),
                  width: mWidth,
                  height: mHeight * 0.4,
                  child: Lottie.asset('assets/images/bus.json')),
            ],
          ),
          Container(
            alignment: Alignment.center,
            // color:Colors.green,
              width: mWidth * 0.8,
              height: mHeight * 0.25,
              child: Text(
                "Our primary function is to promote an affordable, integrated, safe, responsive and sustainable land transport system ",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontSize: mHeight * 0.035,fontFamily:'Amiri' ,),
              ))
        ],
      ),
    );
  }
}
