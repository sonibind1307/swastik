import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../../config/Helper.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/launcher_icon"),
            iOS: DarwinInitializationSettings(
              requestSoundPermission: false,
              requestBadgePermission: false,
              requestAlertPermission: false,
            ));

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (messageData) async {
      var jsonData = jsonEncode(messageData.toString());
      print("notification $jsonData");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print("soni33333333333333");
      handleRemoteMessage(message!);
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android!;
    });
  }

  static handleRemoteMessage(RemoteMessage message) {
    if (message.data.containsKey('alarm_data')) {
      String alarmDataString = message.data['alarm_data'];
      List<dynamic> alarmData = jsonDecode(alarmDataString);

      // Process the alarm data
      for (var alarm in alarmData) {
        try {
          DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(alarm);
          Alarm.set(alarmSettings: Helper.buildAlarmSettings(dateTime))
              .then((res) {});
        } catch (e) {
          print("error_message" + e.toString());
        }
      }
    }
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "popup",
        "popup channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(
        id,
        message.notification!.title!,
        message.notification!.body!,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
