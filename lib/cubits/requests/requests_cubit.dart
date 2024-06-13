import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/cubits/order/order_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/services/dio/request_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  List<Request> requests = [];
 
  RequestsCubit() : super(RequestsInitial());

  void getRequests() async{
    //if(requests.isNotEmpty) return;
    try{
      requests = [];
      emit(LoadingRequestsState());
      RequestServices().get().then((response){
        if(response != null){
          for(var requestJson in response.data["ServiceRequests"]){
            requests.add(
              Request.fromJson(requestJson),
            );
          }
          emit(SuccessRequestsState());
        }
        else{
          emit(FailRequestsState());
        }
      });
    }
    catch(e){
      emit(FailRequestsState());
    }
  }

  Future<void> addRequest(Request request) async{
    requests.add(request);
    emit(OrderAdded());
  }

  // void getRequests(BuildContext context, [bool recall = false]){
  //   if(requests.isEmpty || recall){
  //     try{
  //       emit(LoadingState());
  //       RequestServices().get(Cache.getToken()!).then((response){
  //         if(response != null){
  //           if(response.data["status"] == "success"){
  //             print("success");
  //             if(response.data["data"].isEmpty){
  //               emit(SuccessState());
  //             }
  //             else{
  //               for(var map in response.data["data"]){
  //                 Order order = Order.fromMap(map);
  //                 requests.add(order);
  //                 emit(SuccessState());
  //               }
  //             }
  //           }
  //           else{
  //             print("fail");
  //             emit(FailState());
  //             ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
  //           }
  //         }
  //         else{
  //           print("fail 2");
  //           emit(FailState());
  //           ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
  //         }
  //       });
  //     }
  //     catch(e){
  //       print("fail 3");
  //       emit(FailState());
  //     }
  //   }
  // }  
}
