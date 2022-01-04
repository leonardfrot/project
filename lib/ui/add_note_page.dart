import 'dart:convert';
import 'dart:io';
import 'package:project/notification/notification.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/authentication/authentication.dart';
import 'package:project/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:project/ui/input.dart';
import 'package:project/view/hompage.dart';
import 'package:project/view/theme.dart';

import 'floatingActionButton.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({Key? key, this.loginState, this.noteToEdit}) : super(key: key);
  final ApplicationLoginState? loginState;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // il est présent seulement quand on édite la page
  DocumentSnapshot? noteToEdit;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController noteController = TextEditingController();
  late String buttonName;
  late bool updating;
  File? image;
  String? imagePath;
  List<String> tags = [];
  late bool tagging = false;
  var helper;

  DateTime _selectedDate = DateTime.now();

  late String _alertTime =
      DateFormat("hh:mm:a").format(DateTime.now()).toString();
  int _selectedColor = 0;

  @override
  void initState() {
    if (widget.noteToEdit != null) {
      titleController =
          TextEditingController(text: widget.noteToEdit!.get('title'));
      noteController =
          TextEditingController(text: widget.noteToEdit!.get('note'));
      _selectedDate = DateTime.fromMicrosecondsSinceEpoch(
          widget.noteToEdit!.get('date').microsecondsSinceEpoch);
      _alertTime = widget.noteToEdit!.get('time');
      _selectedColor = widget.noteToEdit!.get('color');
      List temp;
      temp = widget.noteToEdit!.get('tags');

      for (var i = 0; i< temp.length; i++){
        tags.add(temp[i].toString());
      }

      tags.length>0?tagging= true: tagging = false;


      if (widget.noteToEdit!.get('image') != null) {
        image = File(widget.noteToEdit!.get('image'));
      } else {
        image = null;
      }

      buttonName = "update";
      updating = true;
    } else {
      buttonName = "créer";
      updating = false;
    }

    helper = NotificationHelper();
    helper.initializeNotification();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _selectedColor == 0
            ? Colors.blue
            : _selectedColor == 1
                ? Colors.pink
                : Colors.yellow,
        appBar: _appBar(),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                tagging?TextFieldTags(
                    initialTags: tags,
                    tagsStyler: TagsStyler(
                      showHashtag : true,
                      tagTextStyle: const TextStyle(color: Colors.white),
                      tagDecoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      tagCancelIcon: Icon(Icons.cancel,
                          size: 16.0,
                          color: Color.fromARGB(255, 235, 214, 214)),
                      tagPadding: const EdgeInsets.all(10.0),
                    ),
                    textFieldStyler: TextFieldStyler(
                      hintText :'entrez les tag ici',
                      textFieldFilled: false,
                      helperText: "",
                      textFieldFocusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                      ),
                      textFieldBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                      ),
                    ),
                    onTag: (tag) {
                      tags.add(tag);
                      
                    
                    },
                    onDelete: (tag) {
                      tags.remove(tag);
                    },
                    validator: (tag) {
                      if (tag.length > 15) {
                        return "Le tag est trop long";
                      }
                      return null;
                    }): Container(),
                MyFromular(
                  hint: "Title",
                  controller: titleController,
                  height: 52,
                ),
                MyFromular(
                  hint: "Notes",
                  controller: noteController,
                  height: image == null ? 400 : 200,
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
                        onPressed: () {
                          _getTimeFromUser();
                        },
                        icon: Icon(Icons.access_time_rounded))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPalette(),
                    GestureDetector(
                      onTap:
                          updating ? () => _updateNote() : () => _insertNote(),
                      child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blue),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                buttonName,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ))),
                    )
                  ],
                ),
                image != null
                    ? Align(
                        alignment: Alignment.center,
                        child: Stack(children: [
                          Image.file(
                            image!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 120,
                            left: 260,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  image = null;
                                  imagePath = null;
                                });
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.red),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )),
                            ),
                          )
                        ]),
                      )
                    : Container()
              ])),
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
      actions: [
        updating
            ? GestureDetector(
                onTap: () => _deleteNote(),
                child: const Icon(Icons.delete, size: 30))
            : Container(),
        GestureDetector(
            onTap: () => _selectImage(),
            child: const Icon(Icons.photo, size: 30)),
        GestureDetector(
          onTap:() => setState(() {
            
            print("tagging");

            
            tagging&tags.length.isEqual(0)?tagging=false:tagging=true;


          }),
          child: const Icon(Icons.tag),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
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
    if (pickedTime == null) {
      print("pas de temps");
    } else {
      setState(() {
        _alertTime = _formatedTime;
        int minute = int.parse(_alertTime.split(":")[1].split(" ")[0]);
        _selectedDate = DateTime( _selectedDate.year, _selectedDate.month, 
        _selectedDate.day, 
        int.parse(_alertTime.split(":")[0]),
         int.parse(_alertTime.split(":")[1].split(" ")[0]), 0, 0, 0 );
      });

      print(_selectedDate);
    }
  }

  Future _selectImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final imageTemporaly = File(image!.path);

    setState(() {
      this.image = imageTemporaly;
      imagePath = image.path;
    });
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            // on adapte au pattern d'alert time
            hour: int.parse(_alertTime.split(":")[0]),
            minute: int.parse(_alertTime.split(":")[1].split(" ")[0])));
  }

  _insertNote() async {
    print("veuillez sélectionner une date");
    if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "Certain champs sont vide",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      
      await addNoteToGuest();
       helper.showScheduledNotification(scheduledDate: _selectedDate.add(Duration(seconds: 2)));

      

      Get.back();
    }
  }

  _updateNote() async {
    widget.noteToEdit!.reference.update({
      'title': titleController.text,
      'note': noteController.text,
      'date': _selectedDate,
      'time': _alertTime,
      'color': _selectedColor,
      'image': imagePath,
      'tags': tags
    });

    helper.showScheduledNotification(scheduledDate: _selectedDate.add(Duration(seconds: 2)));
    Get.back();
  }

  _deleteNote() async {
    widget.noteToEdit!.reference.delete();
    Get.back();
  }

  _colorPalette() {
    return Column(
      children: [
        Text(
          "Couleur",
          style: subHeadingStyle,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 14,
                        backgroundColor: index == 0
                            ? Colors.blue
                            : index == 1
                                ? Colors.pink
                                : Colors.yellow,
                        child: _selectedColor == index
                            ? Icon(Icons.done, color: Colors.white, size: 16)
                            : Container()),
                  ));
            },
          ),
        )
      ],
    );
  }

  Future<DocumentReference>? addNoteToGuest() {
    return FirebaseFirestore.instance.collection('Notes').add({
      'title': titleController.text,
      'note': noteController.text,
      'date': _selectedDate,
      'time': _alertTime,
      'color': _selectedColor,
      'image': imagePath,
      'userId': widget.auth.currentUser!.uid,
      'createdDate': DateTime.now(),
      'tags' : tags
    });

    
  }
}
