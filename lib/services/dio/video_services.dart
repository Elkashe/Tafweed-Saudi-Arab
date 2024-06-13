import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class VideoServices extends DioServices{

  Future<bool> post(FormData data, String token) async{
    try{
      var response = await dio.post(
        uploadVideoEndPoint, 
        data: data,
        options: Options(
          headers: {
            "authtoken": token,
          }
        ),
      );
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        print(response.data);
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      return false;
    }
  }

  Future<Response?> getByRequest(int requestId) async{
    try{
      var response = await dio.get(
        "$videosEndPoint?request_id=$requestId", 
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