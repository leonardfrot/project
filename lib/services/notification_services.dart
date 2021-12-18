import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    //tz.initializeTimeZones();
 final IOSInitializationSettings initializationSettingsIOS =
     IOSInitializationSettings(
         requestSoundPermission: false,
         requestBadgePermission: false,
         requestAlertPermission: false,
         onDidReceiveLocalNotification: onDidReceiveLocalNotification
     );

   final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("appicon");  

     final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android: initializationSettingsAndroid
    );
    // la fonction principale du set up du plugin
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);
}

Future selectNotification(String? payload) async {
  if(payload != null){
    print('notification payload: $payload');
  
  } else {
    print ("notification done");
  }
  Get.to(()=> Container(color: Colors.red));
}



Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(const Text("Bienvenue à l'application notes"));
  }


   void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


}
