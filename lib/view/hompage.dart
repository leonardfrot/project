import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:project/authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/main.dart';
import 'package:project/notification/notification.dart';

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
  
  
  final User? auth = FirebaseAuth.instance.currentUser;
  final FirebaseAuth? log = FirebaseAuth.instance;
  
  String? uid;
  late final ref;
  var helper;

  @override
  void initState() {
    uid = log!.currentUser?.uid;
    ref = FirebaseFirestore.instance
        .collection('Notes')
        .where('userId', isEqualTo: uid);
    helper = NotificationHelper();
    
    
    helper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(
        children: [
          Text(
            DateFormat.yMMMMd().format(
              DateTime.now(),
            ),
            style: subHeadingStyle,
          ),
          Text("Mes Notes", style: HeadingStyle),
          Flexible(
            child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount:
                          snapshot.hasData ? snapshot.data!.docs.length : 0,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(AddNotePage(
                              noteToEdit: snapshot.data!.docs[index],
                              loginState: widget.loginState,
                            ));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    snapshot.data!.docs[index].get('color') == 0
                                        ? Colors.blue
                                        : snapshot.data!.docs[index]
                                                    .get('color') ==
                                                1
                                            ? Colors.pink
                                            : Colors.yellow,
                              ),
                              margin: EdgeInsets.all(10),
                              height: 150,
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.docs[index].get('title'),
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Created : " +
                                        DateFormat('yyyy-MM-dd  kk:mm')
                                            .format(DateTime
                                                .fromMicrosecondsSinceEpoch(
                                                    snapshot.data!.docs[index]
                                                        .get('createdDate')
                                                        .microsecondsSinceEpoch))
                                            .toString(),
                                    style: const TextStyle(
                                        height: 2,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    "Do before : " +
                                        DateFormat('yyyy-MM-dd  kk:mm')
                                            .format(DateTime
                                                .fromMicrosecondsSinceEpoch(
                                                    snapshot.data!.docs[index]
                                                        .get('date')
                                                        .microsecondsSinceEpoch))
                                            .toString(),
                                    style: const TextStyle(
                                        height: 2,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Flexible(
                                      child: GridView.builder(
                                          itemCount: snapshot.data!.docs[index]
                                              .get('tags')
                                              .length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              5)),
                                          itemBuilder: (_, index2) {
                                            return Container(
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.red),
                                              child: Text("#" +
                                                  snapshot.data!.docs[index]
                                                      .get('tags')[index2]),
                                            );
                                          }))
                                ],
                              )),
                        );
                      });
                }),
          ),
        ],
      ),

      floatingActionButton: MyFloatiatingActionButton(
          label: "+ ajouter",
          onTap: () => Get.to(AddNotePage(
                loginState: widget.loginState,
              ))),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () async {
          Get.to(LoginPage());
          
          
        },
        child: const Icon(
          Icons.logout,
          size: 20,
        ),
      ),
    );
  }
}


