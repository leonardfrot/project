import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFloatiatingActionButton extends StatelessWidget {

  final String label;
  final Function onTap;

  const MyFloatiatingActionButton({ Key? key, required this.label, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap,
      child: Container(
        width: 100,
        height:  60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.blue),
      
        child: Align(
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),

        )
      ),
      
    );
}
}