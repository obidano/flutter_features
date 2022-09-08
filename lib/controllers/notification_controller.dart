import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController with ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationController() {
    init();
    this.requestIOSPermissions();
  }

  Future<void> init() async {
    print('::::::::::::Init notification:::::::::::');
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notifs');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
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

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  void selectNotification(String? payload) {}

  afficherNotification(String message) async {
    await Future.delayed(Duration(milliseconds: 500));
    AndroidNotificationDetails _androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_01',
      'main_app_channel',
      channelDescription: "Pour les notifications de l'application",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentSound: true,
      presentAlert: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: _androidNotificationDetails, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification ODC',
      message,
      platformChannelSpecifics,
      payload: 'Données Notification',
    );
  }
}
