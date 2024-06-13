import 'package:dio/dio.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class CouponServices extends DioServices{
  Future<Response?> get(String promoCode) async{
    try{
      var response = await dio.get(
        "$checkCouponEndPoint?code=$promoCode",
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