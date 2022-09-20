import 'package:bus/consts/values.dart';
import 'package:flutter/material.dart';

Widget TripsCard(double width, double height, BuildContext context) {
  return 
  Padding(
    padding: EdgeInsets.all(width * 0.02),
    child: SizedBox(
      child: Container(
        child: Card(
          elevation: 10,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width * 0.5,
                  height: height * 0.2,
                  child: Image.asset("assets/images/bus.jpg"),
                ),
                SizedBox(
                    width: width * 0.3,
                    height: height * 0.1,
                    child: Center(
                        child: SelectableText(
                      "Suez Canal University",
                      style: TextStyle(
                          fontSize: width * 0.05, fontWeight: FontWeight.bold),
                    ))),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: SizedBox(
                  width: width,
                  height: height * 0.15,
                  child: SelectableText(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nec venenatis massa. Sed magna mauris, varius vel ornare a, finibus ut lectus.",
                    style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.grey,
                        height: 1.2),
                    // textScaleFactor: 0.8,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.02),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(width * 0.5, height * 0.08)),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).scaffoldBackgroundColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(height * 0.03),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          Navigator.pushNamed(context, '/TripInfo');
                        },
                        child: Text(
                          "open",
                          style: TextStyle(
                              fontSize: width * 0.045, color: Colors.red),
                        ),
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    ),
  );
}
