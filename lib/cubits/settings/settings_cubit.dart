import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/dial/dial_cubit.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/auth_services.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/settings_card.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String promoCode;
  SettingsCubit() : super(SettingsInitial());

  void logout(BuildContext context){
    emit(LoadingSettingsState());
    AuthServices().logout().then((response) {
      if(response != null){
        Cache.clear().then((value){
          emit(SuccessState());
          Navigator.pushNamedAndRemoveUntil(context, loginPath, (route) => false);
        });
      }
      else{
        emit(FailState());
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
      }
    });
    
  }

  void showPromoCode(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      context: context, 
      builder: (context){
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  text: AppLocalizations.of(context)!.discount_code, 
                  onSaved: (value){
                    promoCode = value.toString();
                  },
                  onValidate: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.enter_discount_code;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),
              CustomButton(
                text: AppLocalizations.of(context)!.confirmation, 
                onPressed: (){
                  bool valid = _formKey.currentState!.validate();
                  if(valid){
                    _formKey.currentState!.save();

                    Navigator.pop(context);
                    //promoCodeConfirmed(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
