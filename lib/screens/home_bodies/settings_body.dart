// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/dial/dial_cubit.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';
import 'package:tafweed/cubits/profile/profile_cubit.dart';
import 'package:tafweed/cubits/settings/settings_cubit.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/settings_card.dart';
import "package:tafweed/models/currency.dart" as myCurrency;
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:share_plus/share_plus.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    var settingsCubit = BlocProvider.of<SettingsCubit>(context);
    var profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.hello,
                    style: TextStyle(color: Colors.grey, height: 0.5),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return Text(
                        profileCubit.name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    },
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 22,
                child: Text("🕋"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SettingsCard(
            leading: Icon(Icons.person),
            title: AppLocalizations.of(context)!.personal_information,
            subTitle: AppLocalizations.of(context)!
                .your_personal_information_like_name_and_mobile_number_and_password,
            onTap: () {
              Navigator.pushNamed(context, profilePath);
            },
          ),
          SizedBox(
            height: 10,
          ),
          SettingsCard(
            leading: Icon(Icons.currency_exchange),
            title: AppLocalizations.of(context)!.change_currency,
            subTitle: AppLocalizations.of(context)!
                .change_currency_in_the_app_to_another_currency,
            onTap: () {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyName: false,
                showCurrencyCode: true,
                theme: CurrencyPickerThemeData(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
                    inputDecoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                    )),
                onSelect: (Currency currency) {
                  print("symbol -----> ${currency.symbol}");
                  BlocProvider.of<PriceCubit>(context).changeCurrency(context,
                      myCurrency.Currency(currency.code, currency.symbol));
                  print(
                      'Select currency: ${currency.code} , ${currency.flag}, ${currency.symbol}');
                },
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          SettingsCard(
            leading: Icon(Icons.language),
            title: AppLocalizations.of(context)!.choose_app_language,
            //subTitle: "اللغة العربية والانجليزية",
            onTap: () {
              BlocProvider.of<LanguageCubit>(context)
                  .showLanguageBottomSheet(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          // SettingsCard(
          //   leading: Icon(Icons.discount),
          //   title: AppLocalizations.of(context)!.discount_code,
          //   subTitle: AppLocalizations.of(context)!.enter_discount_code_to_get_discount_now,
          //   onTap: () {
          //     settingsCubit.showPromoCode(context);
          //   },
          // ),
          //SizedBox(height: 10),
          
          SettingsCard(
            leading: Icon(Icons.policy),
            title: AppLocalizations.of(context)!.terms_and_privacy,
            subTitle: AppLocalizations.of(context)!
                .learn_about_app_terms_and_your_privacy,
            onTap: () {
              Navigator.pushNamed(context, privacyPolicyPath);
            },
          ),
          SizedBox(height: 10),
          SettingsCard(
            leading: Icon(Icons.share),
            title: AppLocalizations.of(context)!.share,
            onTap: () {
              //Share.share("", subject: "Download app now to reserve Umrah");
            },
          ),
          SizedBox(height: 10),
          SettingsCard(
            leading: Icon(Icons.star_rate_rounded),
            title: AppLocalizations.of(context)!.rate,
            onTap: () {
              //Share.share("", subject: "Download app now to reserve Umrah");
            },
          ),
          SizedBox(height: 10),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if(state is LoadingSettingsState){
                return Loading();
              }
              else{
                return SettingsCard(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  title: AppLocalizations.of(context)!.logout,
                  onTap: () {
                    BlocProvider.of<DialCubit>(context).country = null;
                    settingsCubit.logout(context);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
