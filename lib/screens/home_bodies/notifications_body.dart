import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/notifications/notifications_cubit.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class NotificationsBody extends StatefulWidget {
  const NotificationsBody({super.key});

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  @override
  Widget build(BuildContext context) {
    var notificationsCubit = BlocProvider.of<NotificationsCubit>(context);
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return Visibility(
          visible: notificationsCubit.notifications.isNotEmpty,
          replacement: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  "assets/images/notifications.json",
                  width: 350,
                ),
                Text(
                  AppLocalizations.of(context)!.no_notifications,
                  style: TextStyle(
                      fontSize: 20, color: Colors.grey[600], height: 0.1),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      notificationsCubit.clearAll();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.red[400],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, i) {
                      return Material(
                        elevation: 3,
                        //shadowColor: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade200
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              notificationsCubit.notifications[i],
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[800]),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: notificationsCubit.notifications.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
