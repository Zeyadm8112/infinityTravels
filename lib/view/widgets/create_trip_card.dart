import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Widget CreateTripCard(double width, double height, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(width * 0.04),
    child: SizedBox(
      width: width,
      height: height * 0.2,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Text(
                      "Create new trip",
                      style: TextStyle(fontSize: width * 0.06),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/CreateTripScreen');
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: width * 0.08,
                          color: Colors.red,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
