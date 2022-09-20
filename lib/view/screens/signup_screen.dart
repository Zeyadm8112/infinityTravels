import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/consts/app_colors.dart';
import 'package:bus/main.dart';
import 'package:bus/view/screens/login_screen.dart';
import 'package:bus/view/screens/signup_screen.dart';
import 'package:bus/view_model/register_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../consts/values.dart';
import '../widgets/bezierContainer.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userPhoneNumberController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userConfirmPasswordController =
      TextEditingController();
  bool mVissible = true;
  Widget vissIcon = Icon(Icons.visibility);
  bool mVissibleConfirm = true;
  Widget vissIconConfirm = Icon(Icons.visibility);
  String _userName = "";
  String _userEmail = "";
  String _userPhoneNumber = "";
  String _userPassword = "";
  String _userConfirmPassword = "";

  Widget _backButton(double w, double h) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: h * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 0, top: h * 0.01, bottom: h * 0.01),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 12.dp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo'))
          ],
        ),
      ),
    );
  }

  Widget _title(double w, double h) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'I',
          style:
              // GoogleFonts.portLligatSans(
              TextStyle(
            fontSize: h * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
          children: [
            TextSpan(
              text: 'ce',
              style: TextStyle(color: Colors.black, fontSize: h * 0.05),
            ),
            TextSpan(
              text: 'Code',
              style: TextStyle(color: Colors.red, fontSize: h * 0.05),
            ),
          ]),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.h ),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ' Have an account ?',
              style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 13.dp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              'Login',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.primaryColor,
                  fontSize: 12.dp,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<RegisterViewModel>(context);
    if (provider.state == RegisterScreenState.loading) {
      return SafeArea(
        child: Container(
          width: mWidth,
          height: mHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background4.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: Colors.white.withOpacity(.4),
              body: const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              )),
        ),
      );
    } else if (provider.state == RegisterScreenState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
      provider.state = RegisterScreenState.loaded;
    }
else if (provider.state == RegisterScreenState.sucess) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 4))
          .show(context);
      provider.state = RegisterScreenState.loaded;
    }
    return SafeArea(
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background4.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(.4),
            resizeToAvoidBottomInset: true,
            body: SizedBox(
              width: 100.w,
              height: 100.h,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // _backButton(mWidth, mHeight),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                            // color: Colors.red,
                            height: 10.h,
                            width: 40.w,
                            child: Text('Welcome to our community',
                                style: TextStyle(
                                    fontFamily: 'OleoScriptSwashCaps',
                                    color: Colors.black,
                                    fontSize: 20.dp,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // SizedBox(height: mHeight * .25),
                            // _title(mWidth, mHeight),
                            // SizedBox(height: mHeight * 0.02),

                            SizedBox(
                              height: 1.h,
                            ),

                            SizedBox(
                              width: 90.w,
                              height: 10.h,
                              child: TextFormField(
                                // initialValue: "z",
                                controller: _userNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your name";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),

                                  labelText: "User name",
                                  suffixIcon: Icon(Icons.person_outlined,
                                      // color: Colors.green
                                      ),

                                  // border: lineInputBorder()
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              width: 90.w,
                              height: 10.h,
                              child: TextFormField(
                                controller: _userEmailController,
                                validator: (value) {
                                  // var email = "fredrik@gmail.com";

                                  if (value!.isEmpty) {
                                    return "Enter your account ";
                                  }
                                  if ((EmailValidator.validate(value) ==
                                      true)) {
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                                  labelText: "Account",
                                  suffixIcon: Icon(
                                    Ionicons.logo_google,
                                    // color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),

                            SizedBox(
                              width: 90.w,
                              height: 10.h,
                              child: TextFormField(
                                controller: _userPhoneNumberController,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^(?:[+0]9)?[0-9]{11}$')
                                          .hasMatch(value)) {
                                    return "Enter valid number";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                                  labelText: "Phone number",
                                  suffixIcon: Icon(Icons.phone),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              width: 90.w,
                              height: 10.h,
                              child: TextFormField(
                                obscureText: mVissible,
                                controller: _userPasswordController,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return "The password should be more than 6 digits";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),

                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                      icon: vissIcon,
                                      onPressed: () {
                                        setState(() {
                                          mVissible
                                              ? vissIcon = Icon(
                                                  Icons.visibility_off_sharp)
                                              : vissIcon =
                                                  Icon(Icons.visibility);
                                          mVissible = !mVissible;
                                        });
                                      }),
                                  // border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              width: 90.w,
                              height: 10.h,
                              child: TextFormField(
                                obscureText: mVissibleConfirm,
                                controller: _userConfirmPasswordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Confirm your password";
                                  }
                                  if (value != _userPasswordController.text) {
                                    return "The passowrds aren't matched  ";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),

                                  labelText: "Confirm password",
                                  suffixIcon: IconButton(
                                      icon: vissIconConfirm,
                                      onPressed: () {
                                        setState(() {
                                          mVissible
                                              ? vissIconConfirm = Icon(
                                                  Icons.visibility_off_sharp)
                                              : vissIconConfirm =
                                                  Icon(Icons.visibility);
                                          mVissibleConfirm = !mVissibleConfirm;
                                        });
                                      }),
                                  // border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),

                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  var provider = Provider.of<RegisterViewModel>(
                                      context,
                                      listen: false);
                                  _userName = _userNameController.text;
                                  _userEmail = _userEmailController.text;
                                  _userPhoneNumber =
                                      _userPhoneNumberController.text;
                                  _userPassword = _userPasswordController.text;
                                  _userConfirmPassword =
                                      _userConfirmPasswordController.text;
                                  provider.registerUser(
                                      _userName,
                                      _userPhoneNumber,
                                      _userEmail,
                                      _userPassword,
                                      _userConfirmPassword,
                                      context);
                                  sharedPref!.setString('name', _userName);
                                  sharedPref!.setString('roleName', 'User');
                                  userName = _userName;
                                  roleName = 'User';

                                  // _showMyDialog();

                                } else {}
                                //Auth Logic Here!!!!
                              },
                              child: Container(
                                width: 60.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(2.h)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color:
                                            AppColors.primaryColor.withAlpha(80),
                                          offset: Offset(2, 4),
                                          blurRadius: 8,
                                          spreadRadius: 2)
                                    ],
                                    color:AppColors.primaryColor),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 19.dp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(
                              //     vertical: 0.5.h),
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text('Forgot Password ?',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: Colors.grey,
                                        fontSize: 12.dp,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            // _divider(),
                            // _facebookButton(),
                            // SizedBox(height: mHeight * .055),
                            _createAccountLabel(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(' '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(children: [
                  Image.asset("/assets/image/done.png"),
                  Text('Registered successfully '),
                ])
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.pushNamed(context, '/MainScreenUser');
              },
            ),
          ],
        );
      },
    );
  }
}
