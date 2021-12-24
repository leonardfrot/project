import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/authentication/authentication.dart';

import 'package:project/services/theme_service.dart';
import 'package:project/ui/add_note_page.dart';
import 'package:project/ui/floatingActionButton.dart';
import 'package:project/view/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.loginState}) : super(key: key);
  final ApplicationLoginState? loginState;

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
        body:
        
        Container(
          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: 10,
                                    itemBuilder: (_,index){
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        height: 150,
                                        color: Colors.grey
                                      );
                                    }),
        )





         ,

         

         
         floatingActionButton: MyFloatiatingActionButton(label: "+ ajouter", onTap: ()=> Get.to(AddNotePage )) ,

          );
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
