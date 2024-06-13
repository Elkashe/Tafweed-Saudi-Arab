import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class AuthServices extends DioServices{
  Future<Response?> login(String phone, String password) async{
    try{
      var response = await dio.post(loginEndPoint, data: {
        //"country_id": countryId,
        "email_or_phone": phone, 
        "password": password,
      });
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

  Future<Response?> register(String name, String phone, String password, Gender gender, int countryId) async{
    try{
      // var response = await http.post(
      //   Uri.parse("$baseUrl$registerEndPoint"),
      //   body: 
      // );

      print("$name, $password, $gender, $phone, ${Platform.isAndroid}, $countryId");
      var response = await dio.post(registerEndPoint, data: {
        "name": name,
        "password": password,
        "gender": gender == Gender.male ? 1 : 2,
        "phone_number": phone,
        "phone_type": Platform.isAndroid ? "Android" : "Iphone",
        "country_id": countryId,
      });
      print(response.statusCode);
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return response;
      }
      else{
        return null;
      }
    }
    catch(e){
      print("error: $e");
      return null;
    }
  }

  Future<Response?> edit(Map<String, dynamic> data) async{
    try{
      var response = await dio.post(
        updateProfileEndPoint, 
        data: data, 
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

  Future<Response?> resetPassword(String phone) async{
    try{
      var response = await dio.post(
        resetPasswordEndPoint, 
        data: {
          "phone_number": phone,
        }, 
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

  Future<Response?> deleteAccount(String token) async{
    try{
      var response = await dio.get(
        deleteAccountEndPoint,  
        options: Options(
          headers: {
            "authtoken": token,
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

  Future<Response?> logout() async{
    try{
      var response = await dio.post(
        logoutEndPoint,  
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

