import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:project/ui/add_note_page.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  DocumentSnapshot? noteToEdit;

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('1', 'my channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          icon: '@mipmap/ic_launcher');
  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  initializeNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      Get.to(AddNotePage(noteToEdit: noteToEdit));
    });
  }

  initNote(String id) {
    FirebaseFirestore.instance
        .collection('Notes')
        .where('uuid', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      noteToEdit = querySnapshot.docs.first;
    });
  }

  Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      await flutterLocalNotificationsPlugin
          .show(id, title, body, platformChannelSpecifics, payload: payload);

  Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        platformChannelSpecifics,
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
