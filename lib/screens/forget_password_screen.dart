import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/forget_password/forgetpassword_cubit.dart';
import 'package:tafweed/packages/country_code/country_code.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/loading.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var forgetPassCubit = BlocProvider.of<ForgetPasswordCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgot_password),
        centerTitle: true,
        elevation: 0,
        backgroundColor: secondColor,
        foregroundColor: mainColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.enter_phone_number_to_reset_password,
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
                key: forgetPassCubit.formKey,
                child: Column(
                  children: [
                    CountryCode(),
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
                        forgetPassCubit.phone = value.toString();
                      },
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.incorrect_phone_number;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                builder: (context, state) {
                  if(state is LoadingState){
                    return const Center(
                      child: Loading(),
                    );
                  }
                  else{
                    return CustomButton(
                      text: AppLocalizations.of(context)!.reset_password,
                      onPressed: () {
                        forgetPassCubit.onReset(context);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}