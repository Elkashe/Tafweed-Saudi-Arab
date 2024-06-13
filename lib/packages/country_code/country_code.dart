import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/cubits/dial/dial_cubit.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/packages/country_code/l10n/ar.dart';
import 'package:tafweed/packages/country_code/l10n/en.dart';
import 'countries_screen.dart';
import 'country_module.dart';

class CountryCode extends StatefulWidget {
  const CountryCode({super.key});

  @override
  State<CountryCode> createState() => _CountryCodeState();
}

class _CountryCodeState extends State<CountryCode> {
  //Country country = Country('', "SA", "+966");

  @override
  Widget build(BuildContext context) {
    var dialCubit = BlocProvider.of<DialCubit>(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          //isScrollControlled: true,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CountriesScreen(
                onTap: (value) {
                  dialCubit.changeCountry(value);
                },
              ),
            );
          },
        );
      },
      child: BlocBuilder<DialCubit, DialState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 2,
                color: Colors.grey.shade200,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: dialCubit.country != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountryFlag.fromCountryCode(
                          dialCubit.country!.code,
                          height: 22,
                          width: 45,
                          borderRadius: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        BlocBuilder<LanguageCubit, LanguageState>(
                          builder: (context, state) {
                            return Text(
                              BlocProvider.of<LanguageCubit>(context).lang !=
                                      "ar"
                                  ? en[dialCubit.country?.code]
                                  : ar[dialCubit.country?.code],
                              style: TextStyle(color: Colors.grey[800]),
                            );
                          },
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.enter_your_country,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
