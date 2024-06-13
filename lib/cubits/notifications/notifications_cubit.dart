import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/local/cache.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  List<String> notifications = [];

  NotificationsCubit() : super(NotificationsInitial());

  void clearAll() async{
    await Cache.setNotifications([]);
    notifications = [];
    emit(ClearState());
  }
}
