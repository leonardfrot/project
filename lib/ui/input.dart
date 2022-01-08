import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFromular extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final double height;

  const MyFromular(
      {Key? key,
      required this.hint,
      this.controller,
      this.widget,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    return Container(
      child: Column(children: [
        widget == null ? Container() : Container(child: widget),
        Container(
          height: height,
          decoration: BoxDecoration(border: Border.all()),
          child: TextFormField(
            // il est readonly seulement si un widget est passé en paramètre
            readOnly: widget == null ? false : true,

            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 50,
            autofocus: false,
            cursorColor: Colors.blue,
            controller: controller,

            decoration: InputDecoration(hintText: hint),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
