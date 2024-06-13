// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/cubits/profile/profile_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/packages/country_code/country_code.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/loading.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var genderCubit = BlocProvider.of<GenderCubit>(context);
    var profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.personal_information),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: profileCubit.formKey,
          child: ListView(
            children: [
              // CustomTextFormField(
              //   initial: Cache.getName(),
              //   text: AppLocalizations.of(context)!.full_name,
              //   onSaved: (value) {
              //     profileCubit.name = value.toString();
              //   },
              //   onValidate: (value) {
              //     if (value!.isEmpty) {
              //       return AppLocalizations.of(context)!.enter_your_full_name;
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // CustomTextFormField(
              //   initial: Cache.getPhone(),
              //   prefix: CountryCode(),
              //   keyboardType: TextInputType.phone,
              //   text: AppLocalizations.of(context)!.phone_number,
              //   onSaved: (value) {
              //     profileCubit.phone = value.toString();
              //   },
              //   onValidate: (value) {
              //     if (value!.isEmpty) {
              //       return AppLocalizations.of(context)!.incorrect_phone_number;
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              CustomTextFormField(
                obscureText: true,
                text: AppLocalizations.of(context)!.password,
                onSaved: (value) {
                  profileCubit.password = value.toString();
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_password;
                  }
                  return null;
                },
              ),
              // Row(
              //   children: [
              //     Text(
              //       AppLocalizations.of(context)!.gender,
              //       style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     BlocBuilder<GenderCubit, GenderState>(
              //       builder: (context, state) {
              //         return Radio(
              //           value: Gender.male,
              //           groupValue: genderCubit.selectedGender,
              //           activeColor: mainColor,
              //           onChanged: (value) {
              //             genderCubit.changeGender(value!);
              //           },
              //         );
              //       },
              //     ),
              //     Text(
              //       AppLocalizations.of(context)!.male,
              //       style: TextStyle(
              //         fontSize: 17,
              //         //color: Colors.grey[600]
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     BlocBuilder<GenderCubit, GenderState>(
              //       builder: (context, state) {
              //         return Radio(
              //           value: Gender.female,
              //           groupValue: genderCubit.selectedGender,
              //           activeColor: mainColor,
              //           onChanged: (value) {
              //             genderCubit.changeGender(value!);
              //           },
              //         );
              //       },
              //     ),
              //     Text(
              //       AppLocalizations.of(context)!.female,
              //       style: TextStyle(
              //         fontSize: 17,
              //         //color: Colors.grey[600]
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if(state is LoadingState){
                    return const Loading();
                  }
                  else{
                    return CustomButton(
                      text: AppLocalizations.of(context)!.edit,
                      onPressed: () {
                        profileCubit.onEdit(context);
                      },
                    );
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              CustomButton(
                text: AppLocalizations.of(context)!.delete_account,
                onPressed: () {
                  profileCubit.deleteDialog(context);
                },
                bgColor: Colors.red.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
