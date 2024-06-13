import 'package:dio/dio.dart';
import 'package:tafweed/constants.dart';

abstract class DioServices{
  late Dio dio;
  
  DioServices(){
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: false,
      followRedirects: false,
      validateStatus: (status) { 
        if(status != null){
          return status < 500;
        }
        return false;
      },
      contentType: 'application/json',
      persistentConnection: true
    ));
  }

}