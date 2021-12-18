import 'package:flutter/material.dart';
import 'package:project/services/notification_services.dart';
import 'package:project/services/theme_service.dart';

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
        appBar: _appBar(),
        // ignore: prefer_const_literals_to_create_immutables
        body: Column(children: [
          const Text(
            "test fonctionnement",
            style: TextStyle(fontSize: 13),
          )
        ]));
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap:(){
          print ("tapped");
          ThemeService().switchTheme();

        },
        child: const Icon(Icons.nightlight_round, size: 20, ),
        ),

        actions:const [
          Icon(Icons.person, size: 20, ),

          SizedBox(width: 20, ), 
        
        ],
      );
  }
}
