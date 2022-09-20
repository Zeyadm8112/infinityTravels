import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class ThirdOnBoardScreen extends StatefulWidget {
  const ThirdOnBoardScreen({Key? key}) : super(key: key);

  @override
  State<ThirdOnBoardScreen> createState() => _ThirdOnBoardScreenState();
}

class _ThirdOnBoardScreenState extends State<ThirdOnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    double _angle = 0;
    return Scaffold(
      backgroundColor: Color(0xff65000b),
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
                  child: Lottie.asset('assets/images/support.json')),
            ],
          ),
          Container(
            alignment: Alignment.center,
            // color:Colors.green,
              width: mWidth * 0.8,
              height: mHeight * 0.25,
              child: Text(
                "Your problem, our aim. Call us now for instant customer service.",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontSize: mHeight * 0.035,fontFamily:'Amiri' ,),
              ))
              
        ],
      ),
    );
  }
}
