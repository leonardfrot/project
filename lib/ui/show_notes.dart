import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/services/theme_service.dart';
import 'package:project/view/hompage.dart';
import 'package:get/get.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeService().theme,
      home: const HomePage(),
    );
  }
}
