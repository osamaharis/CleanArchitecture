import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin plugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestnotificationpermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user Granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user Granted  Provisional Permission");
    } else {
      AppSettings.openAppSettings();
      print("Permission Denied");
    }
  }

  Future<String> Devicetoken() async {
    String? token;
    token = await messaging.getToken();
    return token!;
  }

  void IsTokenvalid() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((event) {
      showNotifications(event);
    });
  }

  void initlocalNotificaion(BuildContext context, RemoteMessage message) async {
    var android = const AndroidInitializationSettings("@drawable/notification");
    var initailization = InitializationSettings(android: android);
    await plugin.initialize(initailization,
        onDidReceiveNotificationResponse: (payload) {});
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString()
        ,"high",
        importance: Importance.high);
    AndroidNotificationDetails details = AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: "dkaklsdksajdjds",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');

    NotificationDetails notificationDetails = NotificationDetails(
      android: details,
    );

    Future.delayed(Duration.zero, () {
      plugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }
}
