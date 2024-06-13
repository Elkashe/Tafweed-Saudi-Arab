import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices{
  static FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse notificationResponse){
    onClickNotification.add(notificationResponse.payload!);
  }

  static Future<void> init() async{
    tz.initializeTimeZones();
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id,title,body,payload){
        onClickNotification.add(payload!);
      }
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    var accept = await notificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    if(accept != null){
      if(accept){
        await notificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: onNotificationTap,
          onDidReceiveBackgroundNotificationResponse: onNotificationTap,
        );
      }
    }
  }

  static NotificationDetails getNotificationDetails(){
    return NotificationDetails(
      android: AndroidNotificationDetails("channelId", "channelName", importance: Importance.max, priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );
  }

  static void showNotification(int id, String title, String body){
    notificationsPlugin.show(id, title, body, getNotificationDetails());
  }

  static void showPeriodNotification(int id, String title, String body){
    notificationsPlugin.periodicallyShow(id, title, body, RepeatInterval.daily, getNotificationDetails());
  }

  static Future<void> scheduleNotification() async{
    var now = tz.TZDateTime.now(tz.local);
    await notificationsPlugin.zonedSchedule(
    0,
    'Good',
    'yeeeeeeeeees',
    payload: "Ay 7aga",
    tz.TZDateTime(tz.local, now.year, now.month, now.day, now.hour, now.minute + 1), // appears tommorrow at 2 PM
    const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description')),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
    print("done");
    print("${tz.TZDateTime.now(tz.local).hour}");
  }

  static void cancel(int id){
    notificationsPlugin.cancel(id);
  }

  static void cancelAll(int id){
    notificationsPlugin.cancelAll();
  }


}
