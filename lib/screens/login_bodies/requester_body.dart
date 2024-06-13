import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/login/login_cubit.dart';
import 'package:tafweed/packages/country_code/country_code.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/loading.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class RequesterBody extends StatelessWidget {
  const RequesterBody({super.key});

  @override
  Widget build(BuildContext context) {
    var loginCubit = BlocProvider.of<LoginCubit>(context);
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.enter_your_country_code_and_mobile_number_to_login_as_umrah_needer,
          textAlign: TextAlign.center,
          style: TextStyle(
            //color: mainColor,
            //fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Form(
          key: loginCubit.requesterFormKey,
          child: Column(
            children: [
              const CountryCode(),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                prefix: Icon(
                  Icons.phone_iphone_rounded,
                  color: Colors.grey[600],
                ),
                text: AppLocalizations.of(context)!.mobile_number_without_country_code,
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  loginCubit.phone = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.incorrect_phone_number;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                prefix: Icon(
                  Icons.lock,
                  color: Colors.grey[600],
                ),
                text: AppLocalizations.of(context)!.password,
                obscureText: true,
                onSaved: (value) {
                  loginCubit.password = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_password;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        //SizedBox(height: 10,),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, forgetPasswordPath);
            },
            child: Text(
              AppLocalizations.of(context)!.forgot_password,
              style: TextStyle(
                color: mainColor,
                //fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if(state is LoadingState){
              return const Center(
                child: Loading(),
              );
            }
            else{
              return CustomButton(
                text: AppLocalizations.of(context)!.login,
                onPressed: () {
                  loginCubit.onRequesterLogin(context);
                },
              );
            }
          },
        ),
        const SizedBox(height: 5,),
        CustomButton(
          bgColor: Colors.green.shade600,
          text: AppLocalizations.of(context)!.new_registration,
          onPressed: (){
            Navigator.pushNamed(context, registerPath);
          },
        ),
      ],
    );
  }
}