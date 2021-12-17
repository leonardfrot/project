import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePage_State createState() => HomePage_State();
}

// ignore: camel_case_types
class HomePage_State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // ignore: prefer_const_literals_to_create_immutables
        body: Column(children: [
          const Text(
            "test fonctionnement",
            style: TextStyle(fontSize: 13),
          )
        ]));
  }
}
