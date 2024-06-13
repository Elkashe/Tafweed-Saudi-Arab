import 'package:dio/dio.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/dio_services.dart';
import 'package:tafweed/services/firebase_notifications_services.dart';

class NotificationServices extends DioServices{
  Future<Response?> sendToken() async{
    try{
      String? token = await FirebaseNotificationServices.getToken();
      var response = await dio.post(
        loginEndPoint, 
        data: {
          "user_id": Cache.getUserId(),
	        "token" : token,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${Cache.getToken()}"
          }
        )
      );
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return response;
      }
      else{
        return null;
      }
    }
    catch(e){
      print(e);
      return null;
    }
  }
}