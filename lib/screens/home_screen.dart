import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/requests/requests_cubit.dart';
import 'package:tafweed/screens/home_bodies/notifications_body.dart';
import 'package:tafweed/screens/home_bodies/packages_body.dart';
import 'package:tafweed/screens/home_bodies/requests_body.dart';
import 'package:tafweed/screens/home_bodies/settings_body.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tafweed/services/dio/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  int currentPage = 0;
  late Animation<Offset> navigationBarAnimation;
  late AnimationController controller;
  List<Widget> bodies = [
    const PackagesBody(),
    const RequestsBody(),
    Container(),
    const NotificationsBody(),
    const SettingsBody(),
  ];
  
   Widget _navigationBarContent(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       InkWell(
          onTap: (){
            setState(() {
              currentPage = 0;
            }); 
          },
          child: Column(
            children: [
              Image.asset(
                "assets/images/الرئيسية-07.png",
                width: 35,
                color: currentPage == 0 ? null : Colors.grey,
              ),
              Text(
                AppLocalizations.of(context)!.home,
                style: TextStyle(
                  fontSize: 12,
                  color: currentPage == 0 ? mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: (){
            setState(() {
              currentPage = 1;
            }); 
          },
          child: Column(
            children: [
              Image.asset(
                "assets/images/الطلبات-07.png",
                width: 35,
                color: currentPage == 1 ? null : Colors.grey,
              ),
              Text(
                AppLocalizations.of(context)!.requests,
                style: TextStyle(
                  fontSize: 12,
                  color: currentPage == 1 ? mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: (){
            setState(() {
              currentPage = 2;
            }); 
          },
          child: Column(
            children: [
              Image.asset(
                "assets/images/الحكم الشرعي والفتاوى-07.png",
                width: 35,
                color: currentPage == 2 ? null : Colors.grey,
              ),
              Text(
                AppLocalizations.of(context)!.judgments,
                style: TextStyle(
                  fontSize: 12,
                  color: currentPage == 2 ? mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
         InkWell(
          onTap: (){
            setState(() {
              currentPage = 3;
            }); 
          },
          child: Column(
            children: [
              Image.asset(
                "assets/images/الاشعارات-07.png",
                width: 40,
                color: currentPage == 3 ? null : Colors.grey,
              ),
              Text(
                AppLocalizations.of(context)!.notifications,
                style: TextStyle(
                  fontSize: 12,
                  color: currentPage == 3 ? mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: (){
            setState(() {
              currentPage = 4;
            }); 
          },
          child: Column(
            children: [
              Image.asset(
                "assets/images/الإعدادات-07.png",
                width: 40,
                color: currentPage == 4 ? null : Colors.grey,
                colorBlendMode: BlendMode.srcIn,
              ),
              Text(
                AppLocalizations.of(context)!.settings,
                style: TextStyle(
                  fontSize: 12,
                  color: currentPage == 4 ? mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getTitle(){
    switch(currentPage){
      case 0: return Image.asset("assets/images/side_logo.png", width: 100);//Text(AppLocalizations.of(context)!.choose_whats_best_for_you);
      case 1: return Text(AppLocalizations.of(context)!.requests);
      case 3: return Text(AppLocalizations.of(context)!.notifications);
      case 4: return Text(AppLocalizations.of(context)!.settings);
      default: return Container();
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
    navigationBarAnimation = Tween<Offset>(
      begin: const Offset(0,2),
      end: Offset.zero,
    ).animate((CurvedAnimation(parent: controller, curve: Curves.easeOut)));

    Timer(const Duration(milliseconds: 200), (){
      controller.forward();
    });

    BlocProvider.of<RequestsCubit>(context).getRequests();
    NotificationServices().sendToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
      ),
      body: bodies[currentPage],
      bottomNavigationBar: SlideTransition(
        position: navigationBarAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 3,
              color: Colors.grey[200],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(0),
                // border: Border.all()
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: _navigationBarContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}