import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bus/view_model/create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_colors.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _headerController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _headerController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        var provider = Provider.of<CreatePostViewModel>(context);
    if (provider.state == PostScreenState.loading) {
      return  SafeArea(
        child: Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.blue))),
      );
              
    } else if (provider.state == PostScreenState.failed) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 5))
          .show(context);
          provider.state=PostScreenState.loaded;
    } else if (provider.state == PostScreenState.success) {
      AnimatedSnackBar.material(provider.errorMessage,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3))
          .show(context);
          provider.state=PostScreenState.loaded;
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Post",
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 25.dp),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      height: 10.h,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,

                        // initialValue: "z",
                        controller: _headerController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the post's header line";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontFamily: 'Cairo'),
                          labelText: "Header",
                          // prefixIcon: Icon(Ionicons.text),
                          //  ImageIcon(AssetImage('assets/images/top.png'),size: 40.dp,)
                          constraints: BoxConstraints.expand(),
                          isDense: true, // Added this
                          contentPadding:
                              EdgeInsets.all(8), // border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          height: 10 * 4.h,
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Text";
                              } else {
                                return null;
                              }
                            },
                            controller: _bodyController,
                            maxLines: 10,
                            decoration: InputDecoration(
                                hintText: "اكتب..",
                                hintTextDirection: TextDirection.rtl,
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // userName = sharedPref!.getString('name').toString();
                            // userName =
                                                        provider.postMassege(_headerController.text, _bodyController.text, context);

                            // sharedPref!.getString('roleName').toString();
                          }else{
                          }
                        },
                        child: Text("Post",style: TextStyle(fontSize: 18.dp,fontFamily: 'Cairo'),))
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
