import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MainScreenUser');
              },
              child: Text("User")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MainScreenManager');
              },
              child: Text("Manager"))
        ]),
      ),
    );
  }
}
