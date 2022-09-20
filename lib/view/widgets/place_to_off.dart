import 'package:flutter/material.dart';

Widget PlacesToOff(double mWidth, double mHeight, List locListoff) {
  return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      SelectableText(
        "Places to off : ",
        style: TextStyle(
            fontSize: mWidth * 0.04, color: Colors.black.withOpacity(.6)),
      ),
      SizedBox(
        width: mWidth,
        height: mHeight * 0.4,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: locListoff.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 1.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
          mainAxisExtent: 150,
          ),
          itemBuilder: (BuildContext context, int index) {
            return locListoff[index];
          },
        ),
      ),
    ],
  );
}
