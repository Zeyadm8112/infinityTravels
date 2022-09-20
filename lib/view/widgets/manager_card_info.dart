import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Widget ManagerCardInfo(double mWidth, double mHeight,BuildContext context) {
  return 
  SizedBox(
    width: mWidth,
    height: mHeight * 0.3,
    child: Padding(
      padding:  EdgeInsets.only(top: mHeight * 0.02),
      child: 
      Card(
        
        elevation: 10,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: mWidth * 0.23,
                  height: mHeight * 0.23,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/person.jpg"),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Bill Gates",
                      style: TextStyle(fontSize: mWidth * 0.07),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/ProfileScreen');
                            },
                            icon: Icon(
                              Ionicons.call,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Ionicons.logo_whatsapp,
                              color: Colors.red,
                            )),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
