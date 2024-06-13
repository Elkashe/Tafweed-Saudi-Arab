import 'dart:io';

import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:tafweed/services/dio/dio_services.dart';

class PdfServices extends DioServices{
   Future<File?> download(String url) async{
    try{
      final pdfPath = '${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.pdf';
      var response = await dio.download(url, pdfPath);
      print("status coooooooooooooooooooooooooode: ${response.statusCode}");
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        print("status coooooooooooooooooooooooooode: $pdfPath");
        return File(pdfPath);
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