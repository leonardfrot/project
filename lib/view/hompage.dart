import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // référence à la bdd
  final ref = FirebaseFirestore.instance.collection('Notes');
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        // ignore: prefer_const_literals_to_create_immutables
        body:
        
        
          Column(
            children: [
                Text(DateFormat.yMMMMd().format(DateTime.now(),
                
                ), style: subHeadingStyle,
                
                ),
                Text("Mes Notes",
                style: HeadingStyle), 

              Flexible(
                child: StreamBuilder(
                  stream: ref.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                    
                                              itemCount: snapshot.hasData?snapshot.data!.docs.length : 0,
                                              itemBuilder: (_,index){
                                                return Container(
                                                  margin: EdgeInsets.all(10),
                                                  height: 150,
                                                  color: Colors.grey,
                                                  child: Column(
                                                    children: [
                                                      Text(snapshot.data!.docs[index].get('title')),
                                                      Text(snapshot.data!.docs[index].get('note')),
                                                      Text(DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index].get('date').microsecondsSinceEpoch).toString()),
                                                      Text(snapshot.data!.docs[index].get('time'))
                                                      
                                                      ]
                                                    ,)
                                                );
                                              });
                  }
                ),
              ),
            ],
          ),
        





         

         

         
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
