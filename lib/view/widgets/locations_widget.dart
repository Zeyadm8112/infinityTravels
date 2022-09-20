import 'package:flutter/material.dart';

Widget LoWidget(
    double width, double height, String text, String time, bool check) {
  return ExpansionTile(
    title: Text(text),
    children: [
      Row(
        children: [Checkbox(value: check, onChanged: (check) {}), Text(time)],
      )
    ],
  );
}
