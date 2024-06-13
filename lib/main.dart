import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/dial/dial_cubit.dart';
import 'package:tafweed/cubits/forget_password/forgetpassword_cubit.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/login/login_cubit.dart';
import 'package:tafweed/cubits/notifications/notifications_cubit.dart';
import 'package:tafweed/cubits/order/order_cubit.dart';
import 'package:tafweed/cubits/packages/packages_cubit.dart';
import 'package:tafweed/cubits/performer_requests/performer_requests_cubit.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';
import 'package:tafweed/cubits/profile/profile_cubit.dart';
import 'package:tafweed/cubits/promo/promo_cubit.dart';
import 'package:tafweed/cubits/register/register_cubit.dart';
import 'package:tafweed/cubits/requests/requests_cubit.dart';
import 'package:tafweed/cubits/settings/settings_cubit.dart';
import 'package:tafweed/cubits/track/track_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/firebase_options.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/notifications_list.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/routes.dart';
import 'package:tafweed/screens/forget_password_screen.dart';
import 'package:tafweed/screens/home_screen.dart';
import 'package:tafweed/screens/intro_screen.dart';
import 'package:tafweed/screens/login_screen.dart';
import 'package:tafweed/screens/new_order_screen.dart';
import 'package:tafweed/screens/our_goal_screen.dart';
import 'package:tafweed/screens/profile_screen.dart';
import 'package:tafweed/screens/reset_password_screen.dart';
import 'package:tafweed/screens/review_order_screen.dart';
import 'package:tafweed/screens/test.dart';
import 'package:tafweed/screens/track_screen.dart';
import 'package:tafweed/services/firebase_notifications_services.dart';
import 'package:tafweed/services/local_notification.dart';
import 'package:tafweed/services/stripe_payment/stripe_keys.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache.init();
  await LocalNotificationServices.init();
  Stripe.publishableKey = ApiKeys.publishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseNotificationServices.init();
  print("Firebase token ${await FirebaseNotificationServices.getToken()}");
  print(Cache.getToken());
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LanguageCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var langCubit = BlocProvider.of<LanguageCubit>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => GenderCubit()),
        BlocProvider(create: (context) => ForgetPasswordCubit()),
        BlocProvider(create: (context) => NotificationsCubit()),
        BlocProvider(create: (context) => RequestsCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => DialCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => TrackCubit()),
        BlocProvider(create: (context) => PerformerRequestsCubit()),
        BlocProvider(create: (context) => PriceCubit()),
        BlocProvider(create: (context) => PromoCubit()),
        BlocProvider(create: (context) => PackagesCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Taffweed',
            theme: ThemeData(
              textTheme: TextTheme(bodyLarge: TextStyle(fontSize: langCubit.lang == "ar" || langCubit.lang == "ur" ? 16 : 14)),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                elevation: 5,
                centerTitle: true,
              ),
              fontFamily: 'times new roman',
              primaryColor: mainColor),
            onGenerateRoute: Routes.getRoute,
            //home: FatoraahScreen(),
            locale:
                Locale(langCubit.lang), //BlocProvider.of<LanguageCubit>(context).lang
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          );
        },
      ),
    );
  }
}

@pragma("vn:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
  // if(message.notification != null){
  //   LocalNotificationServices.showNotification(
  //     Random().nextInt(10000), 
  //     message.notification!.title.toString(), 
  //     message.notification!.body.toString(),
  //   );
  // }
  
}
