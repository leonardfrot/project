import 'package:flutter/material.dart';
import 'package:project/view/hompage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // il permet de changer les couleur du background etc.
      theme: ThemeData(
        primaryColor: Colors.red,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.red,
        brightness: Brightness.light

      ),
      home: const HomePage()
    );
  }
}

