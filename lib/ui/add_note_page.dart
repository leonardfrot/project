import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:project/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:project/ui/input.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  DateTime _selectedDate = DateTime.now();
  late String _alertTime = DateFormat("hh:mm:a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyFromular(
                hint: "Title",
                height: 52,
              ),
              const MyFromular(
                hint: "Notes",
                height: 400,
              ),
              MyFromular(
                hint: DateFormat.yMd().format(_selectedDate),
                height: 52,
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              MyFromular(
                hint: _alertTime, 
                height: 52,
                widget: IconButton(
                  onPressed: (){
                    _getTimeFromUser();

                  },
                  icon: Icon(Icons.access_time_rounded)
                )
                
                )
            ],
          )),
        ));
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("veuillez sélectionner une date");
    }

    
  }

  _getTimeFromUser() async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime == null){
      print("pas de temps");
    }else {
      setState(() {
        _alertTime = _formatedTime;
      });
      
      
    };
    }
    
   
  

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context, 
      initialTime: TimeOfDay(
        // on adapte au pattern d'alert time
        hour: int.parse(_alertTime.split(":")[0]), 
        minute: int.parse(_alertTime.split(":")[1].split(" ")[0]) 
        ));
  }

}