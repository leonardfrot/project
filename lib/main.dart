import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/services/theme_service.dart';
import 'package:project/view/hompage.dart';
import 'package:project/view/theme.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  // on doit initialiser getStorage pour le stockage à l'entry point et il doit être asynchrone
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      theme: Themes.light,
      themeMode: ThemeService().theme,

      home: const HomePage()
    );
  }
}

