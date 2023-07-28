import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialize local notification and creating channel
  static void initialize(BuildContext context){
    //local notification initialization
    final InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings("@drawable/ic_launcher"),
      iOS: IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => {
          1,
          "IOS Title", 
          "IOS Body", 
            {
              "to" : "my_fcm_token",
              "notification" : {
                "body" : "sample body",
                "OrganizationId":"2",
                "content_available" : true,
                "mutable_content": true,
                "priority" : "high",
                "subtitle":"sample sub-title",
                "Title":"hello"
                },
              "data" : {
                "msgBody" : "Body of your Notification",
                "msgTitle": "Title of your Notification",
                "msgId": "000001",
                "data" : "This is sample payloadData"
              }
            }
          },
      ),
    );
    _notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async{
      // if(payload != null){
      //   navigatorKey.currentState!.pushNamed(payload);
      // }
    });
  }

  //channel
  //to display on foreground and create a channel
  static void display(RemoteMessage message) async{
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;
      const   NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "mulyankan", //channelId
          "channel mulyankan", //channelName
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: "Sd",
          badgeNumber: 2,
          threadIdentifier: "IOs",
          subtitle: "IOStrue",)
      );
      
      await _notificationsPlugin.show(
        id,
        message.notification!.title, 
        message.notification!.body, 
        notificationDetails,
        payload: message.data['route'],
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  //For Ios
  notificationInitialization() async {
    if (Platform.isIOS) {
      iosPermissionHandler();
    }
    _requestPermissions();
    String? fcm = await messaging.getToken();
    debugPrint('FCM Token => $fcm');
  }

  iosPermissionHandler() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  void _requestPermissions() {
    _notificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    _notificationsPlugin.resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}