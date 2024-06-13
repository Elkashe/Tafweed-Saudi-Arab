import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/models/order.dart';
import 'package:video_player/video_player.dart';
part 'track_state.dart';

class TrackCubit extends Cubit<TrackState> {
  int currentPage = 1;
  int endPage = 4;
  late Order order;
  PageController pageController = PageController();
  VideoPlayerController? arrivedController;
  VideoPlayerController? tawafController;
  VideoPlayerController? safaAndMarwaController;
  VideoPlayerController? cuttingHairController;

  TrackCubit() : super(TrackInitial());

  void next(){
    currentPage <= endPage ? currentPage++ : endPage;
    emit(ChangePageState());
    pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void back(BuildContext context){
    if(currentPage == 1){
      Navigator.pop(context);
    }
    else{
      currentPage > 1 ? currentPage-- : 1;
      emit(ChangePageState());
      pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }

  }

  void onEnd(){
    currentPage = 1;
    arrivedController = tawafController = safaAndMarwaController = cuttingHairController = null;
  }

  void initArrivedController({bool init = false}) async{
    if(arrivedController == null || init){
      try{
        if(order.vidoes[0].approved){
          emit(LoadingArrivedState());
          arrivedController = VideoPlayerController.networkUrl(
            Uri.parse(baseUrl + order.vidoes[0].link!),
          );
          await arrivedController?.initialize();
          emit(InitArrivedState());
        }
      }
      catch(e){
        emit(FailArrivedState());
      }
    }
  }

  void initTawafController({bool init = false}) async{
    if(tawafController == null || init){
      try{
        if(order.vidoes[1].approved){
          emit(LoadingTawafState());
          tawafController = VideoPlayerController.networkUrl(
            Uri.parse(order.vidoes[1].link!),
          );
          await tawafController?.initialize();
          emit(InitTawafState());
        }
      }
      catch(e){
        emit(FailTawafState());
      }
    }
  }

  void initSafaAndMarwaController({bool init = false}) async{
    if(safaAndMarwaController == null || init){
      try{
        if(order.vidoes[2].approved){
          emit(LoadingSafaAndMarwaState());
          safaAndMarwaController = VideoPlayerController.networkUrl(
            Uri.parse(order.vidoes[2].link!),
          );
          await safaAndMarwaController?.initialize();
          emit(InitSafaAndMarwaState());
        }
        
      }
      catch(e){
        emit(FailSafaAndMarwaState());
      }
    }
  }

  void initCuttingHairController({bool init = false}) async{
    if(cuttingHairController == null || init){
      try{
        if(order.vidoes[3].approved){
          emit(LoadingCuttingHairState());
          cuttingHairController = VideoPlayerController.networkUrl(
            Uri.parse(order.vidoes[3].link!),
          );
          await cuttingHairController?.initialize();
          emit(InitCuttingHairState());
        }
      }
      catch(e){
        emit(FailCuttingHairState());
      }
    }
  }
}
