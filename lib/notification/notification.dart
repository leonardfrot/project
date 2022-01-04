import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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
        
      
        
        
        }

  Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      await      
      flutterLocalNotificationsPlugin.show(
          0, 'plain title', 'plain body', platformChannelSpecifics,
          payload: 'item x'); 
}


