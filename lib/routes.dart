import 'package:flutter/material.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/screens/forget_password_screen.dart';
import 'package:tafweed/screens/home_screen.dart';
import 'package:tafweed/screens/intro_screen.dart';
import 'package:tafweed/screens/login_screen.dart';
import 'package:tafweed/screens/new_order_screen.dart';
import 'package:tafweed/screens/order_confirmed_screen.dart';
import 'package:tafweed/screens/order_not_started_screen.dart';
import 'package:tafweed/screens/our_goal_screen.dart';
import 'package:tafweed/screens/performer_requests_screen.dart';
import 'package:tafweed/screens/privacy_policy_screen.dart';
import 'package:tafweed/screens/profile_screen.dart';
import 'package:tafweed/screens/register_screen.dart';
import 'package:tafweed/screens/reset_password_screen.dart';
import 'package:tafweed/screens/review_order_screen.dart';
import 'package:tafweed/screens/show_order_screen.dart';
import 'package:tafweed/screens/splash_screen.dart';
import 'package:tafweed/screens/track_screen.dart';
import 'package:tafweed/screens/video_screen.dart';
import 'package:tafweed/screens/videos_submission_screen.dart';
import 'package:video_player/video_player.dart';

class Routes{
  static Route? getRoute(RouteSettings settings){
    switch(settings.name){
      case loginPath: return MaterialPageRoute(builder: (context) => const LoginScreen());
      case registerPath: return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case startPath: return MaterialPageRoute(builder: (context) => const SplashScreen());
      case forgetPasswordPath: return MaterialPageRoute(builder: (context) => const ForgetPasswordScreen());
      case homePath: return MaterialPageRoute(builder: (context) => const HomeScreen());
      case privacyPolicyPath: return MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen());
      case profilePath: return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case performerReqPath: return MaterialPageRoute(builder: (context) => const PerformerRequestsScreen());
      case introPath: return MaterialPageRoute(builder: (context) => const IntroScreen());
      case ourGoalPath: return MaterialPageRoute(builder: (context) => const OurGoalScreen());
      case videosSubmissionPath: {
        var arg = settings.arguments as int;
        return MaterialPageRoute(builder: (context) => VideosSubmissionScreen(requestIndex: arg,));
      }
      // case newOrderPath:{
      //   var arg = settings.arguments as double;
      //   return MaterialPageRoute(builder: (context) => NewOrderScreen(amount: arg));
      // }
      // case reviewOrderPath: {
      //   var arg = settings.arguments as double;
      //   return MaterialPageRoute(builder: (context) => ReviewOrderScreen(amount: arg));
      // }
      // case orderConfirmedPath: {
      //   var arg = settings.arguments as Order;
      //   return MaterialPageRoute(builder: (context) => OrderConfirmedScreen(order: arg,));
      // }
      // case trackPath: {
      //   var arg = settings.arguments as Order;
      //   return MaterialPageRoute(builder: (context) => TrackScreen(order: arg,));
      // }
      case orderNotStartedPath: {
        String name = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => OrderNotStartedScreen(name: name,));
      }
      case videoPath: {
        var arg = settings.arguments as VideoPlayerController;
        return MaterialPageRoute(builder: (context) => VideoScreen(
          controller: arg
        ));
      }
      case showOrderPath: {
        var arg = settings.arguments as int;
        return MaterialPageRoute(builder: (context) => ShowOrderScreen(
          index: arg,
        ));
      }
      case resetPasswordPath: {
        var arg = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => ResetPasswordScreen(
          phone: arg
        ));
      }
      default: return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}