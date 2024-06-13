// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/login/login_cubit.dart';
import 'package:tafweed/cubits/packages/packages_cubit.dart';
import 'package:tafweed/packages/country_code/country_code.dart';
import 'package:tafweed/screens/login_bodies/performer_body.dart';
import 'package:tafweed/screens/login_bodies/requester_body.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/lang_dropdown.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/login_toggle.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{
  late Animation<Offset> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400)
    );

    animation = Tween<Offset>(
      begin: Offset(0,-2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack)
    );

    Timer(Duration(milliseconds: 200), (){
      controller.forward();
    });

    // String lang = BlocProvider.of<LanguageCubit>(context).lang;
    // BlocProvider.of<PackagesCubit>(context).getPackages(lang);
  }

  @override
  Widget build(BuildContext context) {
    var loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: (){
                BlocProvider.of<LanguageCubit>(context).showLanguageBottomSheet(context);
              },
              child: Image.asset(
                "assets/images/اللغة-01.png",
                width: 40,
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,20),
          child: Column(
            children: [
              SlideTransition(
                position: animation,
                child: Image.asset(
                  'assets/images/rLogo.png',
                  width: 120,
                ),
              ),
              SizedBox(height: 20,),
              Column(
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
              ),
              Spacer(),
              // Expanded(
              //   child: RequesterBody(),
              // ),
              // Expanded(
              //   child: PageView(
              //     controller: loginCubit.pageController,
              //     physics: NeverScrollableScrollPhysics(),
              //     children: const [
              //       RequesterBody(),
              //       PerformerBody(),
              //     ],
              //   ),
              // ),
              SizedBox(height: 20,),
              Text(
                AppLocalizations.of(context)!.registration_agreement,
                style: TextStyle(color: Colors.grey, height: 1),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, privacyPolicyPath);
                },
                child: Text(
                  AppLocalizations.of(context)!.terms_of_use_and_privacy_policy,
                  style: TextStyle(
                    color: mainColor,
                    //height: 0.1
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
