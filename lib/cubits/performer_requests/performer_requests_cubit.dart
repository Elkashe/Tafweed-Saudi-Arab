import 'dart:io';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/services/dio/dio_services.dart';
import 'package:tafweed/services/dio/request_services.dart';
import 'package:tafweed/services/dio/video_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';

part 'performer_requests_state.dart';

class PerformerRequestsCubit extends Cubit<PerformerRequestsState> {
  List<Order> requests = [];
  Set<OrderStatus> completed = {};

  PerformerRequestsCubit() : super(PerformerRequestsInitial());

  Future<XFile?> _takeVideo() async{
    ImagePicker picker = ImagePicker();
    return await picker.pickVideo(source: ImageSource.camera);
  }

  void getRequests(BuildContext context, [bool recall = false]){
    if(requests.isEmpty || recall){
      try{
        emit(LoadingState());
        print("getting requests...");
        RequestServices().get().then((response){
          print("done get requests...");
          if(response != null){
            if(response.data["status"] == "success"){
              for(var map in response.data["data"]){
                Order order = Order.fromMap(map);
                requests.add(order);
                emit(SuccessState());
              }
            }
            else{
              emit(FailState());
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
            }
          }
          else{
            emit(FailState());
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
          }
        });
      }
      catch(e){
        emit(FailState());
      }
    }
  }  

  void sendVideo(int orderIndex, int step) async{
    try{
      XFile? xfile = await _takeVideo();
      if(xfile != null){
        print("Sending video..");
        emit(LoadingVideoState());
        String fileName = xfile.path.split('/').last;
        print("file name: $fileName");
        FormData formData = FormData.fromMap({
          "id": requests[orderIndex].id,
          "step": step,
          "vid": await MultipartFile.fromFile(xfile.path, filename:fileName),
        });
        String token = Cache.getToken()!;
        VideoServices().post(formData, token).then((value){
          if(value){
            //completed.add(orderStatus);
            requests[orderIndex].vidoes[step-1].link = xfile.path;
            emit(VideoSentState());
          }
          else{
            throw("video not uploaded");
          }
        });
      }
      else{
        emit(PerformerRequestsInitial());
      }
    }
    catch(e){
      print("erroooooooooooooooooooooor: $e");
      emit(VideoFailState());
    }
  }

  bool videosCompleted(int orderIndex){
    bool completed = true;
    for(int i=0; i<4; i++){
      if(requests[orderIndex].vidoes[i].link == "none"){
        completed = false;
      }
    }
    return completed;
  }
}
