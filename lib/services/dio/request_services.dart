import 'package:dio/dio.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class RequestServices extends DioServices{
  Future<Response?> requestWithoutPayment(Map<String, dynamic> data) async{
    try{
      var response = await dio.post(
        newRequestEndPoint, 
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${Cache.getToken()}",
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
      return null;
    }
  }

  Future<Response?> get() async{
    try{
      var response = await dio.get(
        "$myRequestEndPoint?user_id=${Cache.getUserId()}", 
        options: Options(
          headers: {
            "Authorization": "Bearer ${Cache.getToken()}",
          }
        ),
      );
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return response;
      }
      else{
        return null;
      }
    }
    catch(e){
      return null;
    }
  }

  Future<Response?> getDetailsById(int id) async{
    try{
      var response = await dio.get(
        "$requestDetailsEndPoint?request_id=$id", 
        options: Options(
          headers: {
            "Authorization": "Bearer ${Cache.getToken()}",
          }
        ),
      );
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return response;
      }
      else{
        return null;
      }
    }
    catch(e){
      return null;
    }
  }

   Future<Response?> addPayment(Request request) async{
    try{
      var response = await dio.post(
        requestPaymentEndPoint,
        data: {
          "id": request.id,
          "payment_id": request.paymentId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${Cache.getToken()}",
          }
        ),
      );
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return response;
      }
      else{
        return null;
      }
    }
    catch(e){
      return null;
    }
  }
}