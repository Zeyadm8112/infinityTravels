import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/consts/app_colors.dart';
import 'package:bus/consts/values.dart';
import 'package:bus/main.dart';
import 'package:bus/view/screens/signup_screen.dart';
import 'package:bus/view_model/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../widgets/bezierContainer.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool mVissible = true;
  Widget vissIcon = Icon(Icons.visibility);
  final formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPasswordController = new TextEditingController();

  String _userName = "";
  String _userPassword = "";
  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical:2.h),
        // padding: EdgeInsets.all(3.w),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 15.dp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              'Register',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.primaryColor,
                  fontSize: 14.dp,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton(double w, double h) {
    var provider = Provider.of<TokenViewModel>(context);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: h * 0.02),
        child: Row(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 0, top: h * 0.01, bottom: h * 0.01),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style:
                    TextStyle(fontSize: h * 0.02, fontWeight: FontWeight.w500))
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

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<TokenViewModel>(context);
    if (provider.state == ScreenState.loading) {
      return SafeArea(
        child: Container(
          width: mWidth,
        height: mHeight,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background3.png'),
                fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.white.withOpacity(.4),
              body:const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              )),
        ),
      );
    } else if (provider.state == ScreenState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
          provider.state=ScreenState.loaded;
    }

    return SafeArea(
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background3.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(.4),
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(mHeight * 0.02),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: mWidth * 0.04),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: mHeight * 0.05),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 17.h,
                                      width: 40.w,
                                      child: Text('Welcome Back',
                                          style: TextStyle(
                                              fontFamily: 'OleoScriptSwashCaps',
                                              color: Colors.black,
                                              fontSize:  35.dp,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ),
                              SizedBox(height: 4.h),
                              // _emailPasswordWidget(),
                              // SizedBox(
                              //   height: mHeight * 0.03,
                              // ),

                              SizedBox(
                                                              width: 90.w,
                              height: 10.h,

                                child: TextFormField(
                                  // initialValue: "z",
                                  controller: _userNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter you user name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                                    labelText: "User name",
                                    suffixIcon: Icon(Icons.person_outlined),
                              
                                    // border: InputBorder.none
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
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
                              SizedBox(height: 10.h),
                              InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    var provider = Provider.of<TokenViewModel>(
                                        context,
                                        listen: false);
                                    _userName = _userNameController.text;
                                    _userPassword =
                                        _userPasswordController.text;
                                    provider.fetchTokens(
                                        _userName, _userPassword, context);
                                    // =_userName;
                                    sharedPref!.setString('name', _userName);
                                    // userName = sharedPref!.getString('name').toString();
                                    // userName =
                                    // sharedPref!.getString('roleName').toString();
                                  }

                                  //Auth Logic Here!!!!
                                },
                                child: Container(
                                  width: 70.w,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.h)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: AppColors.primaryColor
                                                .withAlpha(80),
                                            offset: Offset(2, 4),
                                            blurRadius: 8,
                                            spreadRadius: 2)
                                      ],
                                      color: AppColors.primaryColor),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize:18.dp,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.h),
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text('Forgot Password ?',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.grey,
                                          fontSize: 15.dp,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              // SizedBox(
                              //   height: 2.h,
                              // ),
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
              ),
            )),
      ),
    );
  }
}
