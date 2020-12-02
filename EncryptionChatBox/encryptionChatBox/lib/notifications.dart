import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encryptionChatBox/logic/auth/authLogic.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TriggerNotification{
  final String serverToken = 'AAAA13yWk3g:APA91bE3x2rQySkltvQsWi_J7m-LBMBA-GWJX0yK9ecLc2K2tAMEdDnTKN51pCpWN-Pahv85GvbUuJJT64xXPvwLVtv_Y2kfsKnB2e2gaIQVoSDzUUsu7ZcyWMt4WFe6J0kI4iNuE4SY';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage(DocumentSnapshot targetUser, String message, String title) async {
    print("Sending..");
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    if(targetUser.data()['pushToken'].trim() != "" || targetUser.data()['pushToken'] != null){
      var rs = await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': targetUser.data()['pushToken'],
        },
        ),
      );
      print(rs.statusCode);
      print(rs.body);

      
    }
    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          completer.complete(message);
        },
      );

    return completer.future;
  }
}

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  
  @override
  void initState() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      Platform.isAndroid ? AuthLogic().showNotification(message['notification']) : AuthLogic().showNotification(message['aps']['alert']);
      return;
    },
    onBackgroundMessage: (Map<String, dynamic> message){
      print('onMessage: $message');
      Platform.isAndroid ? AuthLogic().showNotification(message['notification']) : AuthLogic().showNotification(message['aps']['alert']);
      return;
    }, 
    onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}