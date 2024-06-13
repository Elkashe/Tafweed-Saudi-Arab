import 'dart:io';

import 'package:tafweed/services/dio/pdf_services.dart';
import 'package:video_player/video_player.dart';

class RequestVideo{
  String? enName;
  String? arName;
  String? trName;
  String? urName;
  String? idName;
  String? video;
  VideoPlayerController? controller;
  String? extension;
  File? pdf;

  RequestVideo({this.video, this.enName, this.arName, this.idName, this.trName, this.urName});
  RequestVideo.fromJson(Map<String, dynamic> json){ 
    video = json['video_url'];
    arName = json["name_ar"];
    enName = json["name_en"];
    trName = json["name_tr"];
    urName = json["name_ur"];
    idName = json["name_ind"];
    extension = json["file_extension"];
    if(extension == "mp4"){
      controller = VideoPlayerController.networkUrl(
        Uri.parse(video!),
      );
      controller?.initialize();
    }
    // else{
    //   PdfServices().download(video!).then((value){
    //     pdf = value;
    //     print("pdf ->>>>>>>>>>> $pdf");
    //   });
    // }
  }

  String getName(String langCode){
     if(langCode == "ar"){
      return arName!;
    }
    else if(langCode == "en"){
      return enName!;
    }
    else if(langCode == "tr"){
      return trName!;
    }
    else if(langCode == "ur"){
      return urName!;
    }
    else{
      return idName!;
    }
  }
}