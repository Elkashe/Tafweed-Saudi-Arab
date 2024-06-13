
import 'package:dio/dio.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class PromoServices extends DioServices{

  Future<Response?> post(String promoCode) async{
    try{
      var response = await dio.post(
        promoCodeEndPoint, 
        data: {
          "copounName": promoCode,
        },
      );
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        print(response.data);
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