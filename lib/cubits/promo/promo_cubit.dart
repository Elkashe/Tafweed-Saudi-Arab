import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/services/dio/promo_code_services.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  String? promoCode;
  double percent = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PromoCubit() : super(PromoInitial());

  void onSubmit(BuildContext context) async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      PromoServices().post(promoCode!).then((response){
        if(response != null){
          if(response.data['status'] == "success"){
            promoCodeConfirmed(context);
            percent = 0.1;
            emit(PromoCodeState());
          }
          else{
            promoCodeDenied(context);
          }
        }
        else{
          promoCodeDenied(context);
        }
      });
    }
  }

  void promoCodeConfirmed(BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/confirmed.json',
                    width: 100,
                    repeat: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void promoCodeDenied(BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/wrong.json',
                    width: 100,
                    repeat: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
