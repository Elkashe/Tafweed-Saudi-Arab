import 'package:dio/dio.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class CurrencyServices{
  final String apiKey = "e130f16cb4-ef8e1d664e-sa5fo9";

  Future<double?> get(String to) async{
    try{
      var response = await Dio().post("https://api.fastforex.io/fetch-one?from=SAR&to=$to&api_key=$apiKey");
      if(response.statusCode! >=200 && response.statusCode! < 300){
        return response.data['result'][to];
      }
      else{
        throw("returns ${response.statusCode}");
      }
    }
    catch(e){
      return null;
    }
  }
}