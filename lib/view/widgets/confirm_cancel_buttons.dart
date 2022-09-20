import 'package:flutter/material.dart';

Widget zButton(double width,double height,BuildContext context , Function doFun){
  return             
    Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(width * 0.3, height * 0.07)),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).scaffoldBackgroundColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(height * 0.03),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: width * 0.04, color: Colors.red),
                        ),
                      )),
                                        Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(width * 0.3, height * 0.07)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(height * 0.03),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          doFun;
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: width * 0.04, color: Colors.white),
                        ),
                      ))

                ],
              );

}