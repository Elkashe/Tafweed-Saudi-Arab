import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/notifications/notifications_cubit.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/notifications_list.dart';
import 'package:tafweed/screens/intro_screen.dart';
import 'package:tafweed/services/local_notification.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    // Notifications
    if(Cache.getToken() != null){
      List<String> notifications = Cache.getNotifications() ?? [];
      var notification = NotificationsList.getRandomNotification();
      notifications.add(notification);
      Cache.setNotifications(notifications);
      BlocProvider.of<NotificationsCubit>(context).notifications = notifications;
      Cache.setNotifications(notifications);
      LocalNotificationServices.showPeriodNotification(0, "Taffweed", notification);
    }

    // Navigation to next screen
    Timer(const Duration(milliseconds: 1200), (){
      if(Cache.getToken() != null){
        Navigator.pushReplacementNamed(context, homePath);
      }
      else{
        Navigator.pushReplacementNamed(context, introPath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.05,
            image: AssetImage(
              'assets/images/kaaba.jpeg',
            ),
          )
        ),
        child: Center(
          child: Image.asset(
            'assets/images/rLogo.png',
            width: 180,
          ),
        ),
      ),
    );
  }
}