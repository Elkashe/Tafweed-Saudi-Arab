import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tafweed/services/local_notification.dart';

abstract class FirebaseNotificationServices{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static void requestPermission() async {
    var settings = await messaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("authoriiiiiiiiiiiiiiiiiiized");
    }
    else{
      print("Not authorizeeeeeeeeed");
    }
  }

  static void init(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        Random rand = Random();
        LocalNotificationServices.showNotification(
          rand.nextInt(10000), 
          message.notification!.title.toString(), 
          message.notification!.body.toString(),
        );
      }
    });
  }

  static Future<String?> getToken()async{
    return await messaging.getToken();
  }
}