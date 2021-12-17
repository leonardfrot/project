import 'package:flutter/material.dart';
import 'package:project/view/hompage.dart';
import 'package:project/view/theme.dart';

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
      
      theme: Themes.light,
      themeMode: ThemeMode.light,

      home: const HomePage()
    );
  }
}

