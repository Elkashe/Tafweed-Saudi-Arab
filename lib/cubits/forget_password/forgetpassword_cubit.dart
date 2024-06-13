import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/auth_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'forgetpassword_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String phone;

  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  void onReset(BuildContext context) async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      print(phone);
      emit(LoadingState());
      String? dialCode = Cache.getDialCode();
      if(dialCode == null){
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.enter_your_country, Colors.red));
        return;
      }
      //String totalPhone = dialCode.split("/").last + phone;
      String requestPhone = phone;
      if(phone.startsWith("0")){
        requestPhone = requestPhone.substring(1);
      }
      if(requestPhone.startsWith(dialCode)){
        requestPhone = "+$requestPhone";
      }
      else{
        requestPhone = "+$dialCode$requestPhone";
      }
      AuthServices().resetPassword(requestPhone).then((response){
        if(response != null){
          emit(SuccessState());
          Navigator.pushNamed(context, resetPasswordPath, arguments: requestPhone);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.incorrect_phone_number, Colors.red));
        }
      });
      
    }
  }
}
