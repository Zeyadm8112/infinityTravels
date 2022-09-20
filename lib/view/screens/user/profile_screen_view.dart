import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Positioned(
            //   top: 30,

            //   child: IconButton(
            //     icon: Icon(Icons.arrow_back,color: Colors.black,),
            //     onPressed: () {
            //       Navigator.canPop(context);
            //     },
            //   ),
            // ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red[800]!, Colors.redAccent],
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(
                             height: mHeight * 0.02,
                           ),
                          CircleAvatar(
                            radius: mWidth * 0.2,
                            backgroundImage:
                                AssetImage('assets/images/zeyad.jpeg'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            height: mHeight * 0.001,
                          ),
                          Text('Zeyad Mohamed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: mWidth * 0.055,
                              )),
                          SizedBox(
                            height: mHeight * 0.004,
                          ),
                          Text(
                            'Faculty Of Sciences',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mWidth * 0.03,
                            ),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                        child: Card(
                            child: SizedBox(
                                width: mWidth,
                                height: mHeight * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.all(mWidth * 0.02),
                                  child: SizedBox(
                                    width: mWidth,
                                    height: mHeight * 0.1,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: [
                                          //     Text(
                                          //       "About",
                                          //       style: TextStyle(
                                          //           fontSize: mWidth * 0.045,
                                          //           fontWeight: FontWeight.w800,
                                          //           color: Colors.red),
                                          //     ),
                                          //   ],
                                          // ),
                                          // Divider(
                                          //   color: Colors.grey[300],
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Ionicons.school,
                                                color: Colors.blueAccent[400],
                                                size: mWidth * 0.12,
                                              ),
                                              SizedBox(
                                                width: mWidth * 0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "University",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.05,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Suez Canal",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.04,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: mHeight * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Ionicons.location_outline,
                                                color: Colors.green,
                                                size: mWidth * 0.12,
                                              ),
                                              SizedBox(
                                                width: mWidth * 0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Adress",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.05,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Suez-Salam1",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.04,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: mHeight * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Ionicons.call_outline,
                                                color: Colors.yellow,
                                                size: mWidth * 0.12,
                                              ),
                                              SizedBox(
                                                width: mWidth * 0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Phone",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.05,
                                                    ),
                                                  ),
                                                  SelectableText(
                                                    "+201020622808",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.04,
                                                      color: Colors.grey[400],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: mHeight * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: mWidth * 0.12,
                                              ),
                                              SizedBox(
                                                width: mWidth * 0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Favourite Location",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.05,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Osman St.",
                                                    style: TextStyle(
                                                      fontSize: mWidth * 0.04,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )))),
                  ),
                ),
              ],
            ),
            // Positioned(
            //     top: MediaQuery.of(context).size.height * 0.45,
            //     left: 20.0,
            //     right: 20.0,
            //     child: Card(
            //         child: Padding(
            //       padding: EdgeInsets.all(16.0),
            //       child: Center(child: Text("About"),)

            //     ),),)
          ],
        ),
      ),
    );
  }
}
