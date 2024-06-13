import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/auth_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  late String name;
  late String phone;
  late String password;
  late String confirmedPassword;
  
  RegisterCubit() : super(RegisterInitial());

  void onRegister(BuildContext context) async{
    regFormKey.currentState?.save();
    bool valid = regFormKey.currentState?.validate() ?? false;
    if(valid){
      emit(LoadingState());
      AuthServices authServices = AuthServices();
      String? dialCode = Cache.getDialCode();
      if(dialCode == null){
        emit(FailState());
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.enter_your_country, Colors.red));
        return;
      }
      dialCode = dialCode.split("/").last.substring(1); //+201227701988
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
      Response? response = await authServices.register(name, requestPhone, password, Cache.getGender(), Cache.getCountryId()!);
      if(response != null){
        print(response.data);
        emit(SuccessState());
        //regFormKey.currentState?.dispose();
        //ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.login, Colors.red));
        Navigator.pop(context);
      }
      else{
        emit(FailState());
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
        }
      }
    }
  }
}
