import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/dial/dial_cubit.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/auth_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  GlobalKey<FormState> requesterFormKey = GlobalKey<FormState>();
 // GlobalKey<FormState> perfomerFormKey = GlobalKey<FormState>();
  PageController pageController = PageController();
  late String phone;
  late String password;

  LoginCubit() : super(LoginInitial());

  void onRequesterLogin(BuildContext context) async{
    //requesterFormKey.currentState?.dispose();
    bool valid = requesterFormKey.currentState!.validate();
    if(valid){
      requesterFormKey.currentState!.save();
      AuthServices authServices = AuthServices();
      String? dialCode = Cache.getDialCode();
      if(dialCode == null){
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.enter_your_country, Colors.red));
        return;
      }
      dialCode = dialCode.split("/").last.substring(1);
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
      emit(LoadingState());
      print("requestPhone ---> $requestPhone");
      Response? response = await authServices.login(requestPhone, password);
      if(response != null){
        print(response.data);
        emit(SuccessState());
        await Cache.setPhone(requestPhone);
        await saveInCache(response);
        Navigator.pushNamedAndRemoveUntil(context, homePath, (route) => false);
      }
      else{
        emit(FailState());
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.invalid_phone_number_or_password, Colors.red));
        }
      }
    }
  }

  // void onPerformerLogin(BuildContext context) async{
  //   bool valid = perfomerFormKey.currentState!.validate();
  //   if(valid){
  //     perfomerFormKey.currentState!.save();
  //     emit(PerformerLoadingState());
  //     AuthServices authServices = AuthServices();
  //     String? dialCode = Cache.getDialCode();
  //     if(dialCode == null){
  //       ScaffoldMessenger.of(context).showSnackBar(customSnackBar("أدخل بلدك", Colors.red));
  //       return;
  //     }
  //     Response? response = await authServices.login("$dialCode$phone", password);
  //     if(response != null){
  //       print(response.data);
  //       if(response.data["status"] == "success"){
  //         if(response.data["data"]["type"] == "2"){
  //           saveInCache(response).then((value){
  //             emit(PerformerSuccessState());
  //             Navigator.pushReplacementNamed(context, performerReqPath);
  //           });
  //         }
  //         else{
  //           emit(PerformerFailState());
  //           if(context.mounted){
  //             ScaffoldMessenger.of(context).showSnackBar(customSnackBar("خطأ في الرقم او كلمة المرور", Colors.red));
  //           }
  //         }
  //       }
  //       else{
  //         emit(PerformerFailState());
  //         if(context.mounted){
  //           ScaffoldMessenger.of(context).showSnackBar(customSnackBar("خطأ في الرقم او كلمة المرور", Colors.red));
  //         }
  //       }
  //     }
  //     else{
  //       emit(PerformerFailState());
  //       if(context.mounted){
  //         ScaffoldMessenger.of(context).showSnackBar(customSnackBar("اعد المحاولة مرة اخرى", Colors.red));
  //       }
  //     }
  //   }
  // }

  void togglePage(){
    if(pageController.page == 0){
      pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
    else{
      pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  Future<void> saveInCache(Response response) async{
    await Cache.setName(response.data["user"]["name"]);
    await Cache.setGender(response.data["user"]["gender"] == 1 ? Gender.male : Gender.female);
    await Cache.setToken(response.data["token"]);
    await Cache.setUserId(response.data["user"]["id"]);
  }
}
