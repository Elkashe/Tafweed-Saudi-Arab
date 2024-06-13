import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/cubits/register/register_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/packages/country_code/country_code.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/loading.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var registerCubit = BlocProvider.of<RegisterCubit>(context);
    var genderCubit = BlocProvider.of<GenderCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.new_registration),
        centerTitle: true,
        elevation: 0,
        backgroundColor: secondColor,
        foregroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: registerCubit.regFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                prefix: Icon(
                  Icons.person,
                  color: Colors.grey[600],
                ),
                text: AppLocalizations.of(context)!.full_name,
                onSaved: (value) {
                  registerCubit.name = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_full_name;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
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
                  registerCubit.phone = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_mobile_number;
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
                  registerCubit.password = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_password;
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
                text: AppLocalizations.of(context)!.confirm_password,
                obscureText: true,
                onSaved: (value) {
                  registerCubit.confirmedPassword = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_password_to_confirm;
                  } else if (registerCubit.password !=
                      registerCubit.confirmedPassword) {
                    return AppLocalizations.of(context)!.passwords_do_not_match;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.gender,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<GenderCubit, GenderState>(
                    builder: (context, state) {
                      return Radio(
                        value: Gender.male,
                        groupValue: genderCubit.selectedGender,
                        activeColor: mainColor,
                        onChanged: (value) {
                          genderCubit.changeGender(value!);
                        },
                      );
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.male,
                    style: TextStyle(
                      fontSize: 17,
                      //color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<GenderCubit, GenderState>(
                    builder: (context, state) {
                      return Radio(
                        value: Gender.female,
                        groupValue: genderCubit.selectedGender,
                        activeColor: mainColor,
                        onChanged: (value) {
                          genderCubit.changeGender(value!);
                        },
                      );
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.female,
                    style: TextStyle(
                      fontSize: 17,
                      //color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(
                      child: Loading(),
                    );
                  } else {
                    return CustomButton(
                      text: AppLocalizations.of(context)!.register,
                      onPressed: () {
                        registerCubit.onRegister(context);
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
