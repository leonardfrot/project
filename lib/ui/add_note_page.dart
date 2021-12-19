import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/services/theme_service.dart';
import 'package:get/get.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children:[
          Container(decoration: BoxDecoration(border:Border.all()),
          child: TextField(
            decoration: InputDecoration(hintText: 'Titre'))
          )
        ]
      )
      
    );
  }

   _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap:(){
          Get.back();
          
        },
        child: const Icon(Icons.arrow_back, size: 20, ),
        ),

        actions:const [
          Icon(Icons.person, size: 20, ),

          SizedBox(width: 20, ), 
        
        ],
      );
   }
   
   
   }