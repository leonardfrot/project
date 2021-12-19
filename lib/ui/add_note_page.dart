import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/services/theme_service.dart';
import 'package:get/get.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Container(margin: EdgeInsets.symmetric(horizontal: 20),
        
          child: Column(children: [
          Container(
              decoration: BoxDecoration(border: Border.all()),
              child:  TextFormField(
                  decoration: InputDecoration(hintText: 'Titre'))),
                  SizedBox(height: 10,),
          Expanded(
            child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextFormField(
                  maxLines: null,
                  expands : true,
                    decoration: InputDecoration(hintText: 'Taper le texte ici'))),
          ),
          SizedBox(height: 10,),

          Container(
            decoration: BoxDecoration(border: Border.all()),
              child:  TextFormField(
                  readOnly: widget ==null?false: true,
                  decoration: InputDecoration(hintText: 'Titre'))),
                  SizedBox(height: 10,),

          
           
                  
        ]),
        
        ),
        );
        
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back,
          size: 20,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
