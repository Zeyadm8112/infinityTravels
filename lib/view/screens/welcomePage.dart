// import 'package:bus/view/screens/login_screen.dart';
// import 'package:bus/view/screens/signup_screen.dart';
// import 'package:flutter/material.dart';


// class WelcomeScreen extends StatelessWidget {


//   // @override
//   // _WElcomeScreenState createState() => _WElcomeScreenState();


//   Widget _submitButton(double w,double h,BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => LoginScreen()));
//       },
//       child: Container(
//         width: w,
//          padding: EdgeInsets.symmetric(vertical: h * 0.02),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(h * 0.01)),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Color(0xffdf8e33).withAlpha(100),
//                   offset: Offset(2, 4),
//                   blurRadius: 8,
//                   spreadRadius: 2)
//             ],
//             color: Colors.white),
//         child: Text(
//           'Login',
//           style: TextStyle(fontSize: h * 0.03, color: Colors.red),
//         ),
//       ),
//     );
//   }

//   Widget _signUpButton(double w,double h,BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => SignUpPage()));
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//          padding: EdgeInsets.symmetric(vertical: h * 0.02),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(h * 0.01)),
//           border: Border.all(color: Colors.white, width: w * 0.01),
//         ),
//         child: Text(
//           'Register now',
//           style: TextStyle(fontSize: h * 0.03, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _label() {
//     return Container(
//         margin: EdgeInsets.only(top: 40, bottom: 20),
//         child: Column(
//           children: <Widget>[
//             Text(
//               'Quick login with Touch ID',
//               style: TextStyle(color: Colors.white, fontSize: 17),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Icon(Icons.fingerprint, size: 90, color: Colors.white),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Touch ID',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 15,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ],
//         ));
//   }

//   Widget _title(double w,double h) {
//     return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(text: 'I',
//            style: 
//           // GoogleFonts.portLligatSans(
//             TextStyle(
//             fontSize: h * 0.05,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//       ),
//           children: [
//             TextSpan(
//               text: 'ce',
//               style: TextStyle(color: Colors.black, fontSize:h * 0.05),
//             ),
//             TextSpan(
//               text: 'Code',
//               style: TextStyle(color: Colors.white, fontSize: h * 0.05),
//             ),
//           ]),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double mWidth = MediaQuery.of(context).size.width;
//     double mHeight = MediaQuery.of(context).size.height;
// Color mRed=Color(0xffAA0000);
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: EdgeInsets.symmetric(horizontal: mWidth * 0.02),
//           height: mHeight,
//           decoration: BoxDecoration(
//               // borderRadius: BorderRadius.all(Radius.circular(5)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: Colors.grey.shade200,
//                     offset: Offset(2, 4),
//                     blurRadius: 5,
//                     spreadRadius: 2)
//               ],
//               gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xffEF0107), mRed])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _title(mWidth,mHeight),
//               SizedBox(
//                 height: 80,
//               ),
//               _submitButton(mWidth,mHeight,context),
//               SizedBox(
//                 height: 20,
//               ),
//               _signUpButton(mWidth,mHeight,context),
//               SizedBox(
//                 height: 20,
//               ),
//               // _label()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
