import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/services/dio/country_services.dart';

import 'countries_list.dart';
import 'country_module.dart';
import 'l10n/ar.dart';
import 'l10n/en.dart';

class CountriesInfo{
  static List<Country> countries = [];
  static Future<List<Country>> getCountriesInfo(BuildContext context) async{
    //List<Country> countries = [];
    var response = await CountryServices().get();
    if(response != null){
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        for(var country in response.data["countries"]){
          countries.add(
            Country(country["id"], country["name_en"], country["name_ar"], country["iso_code"], country["phone_key"]),
          );
        }
      }
    }
    // for(var country in CountriesList.countries){
    //   if(en[country['code']] == null || ar[country['code']] == null){
    //     continue;
    //   }
    //   print(BlocProvider.of<LanguageCubit>(context).lang);
    //   String name = BlocProvider.of<LanguageCubit>(context).lang != 'ar' ? 
    //     en[country['code']] is String ? en[country['code']] : en[country['code']][1] : ar[country['code']];
    //   Country newCountry = Country(
    //     name,
    //     country['code'],
    //     country['dial_code']
    //   );
    //   countries.add(newCountry);
    // }
    return countries;
  }

  static List<Country> filterCountries(BuildContext context, List<Country> countries, String value){
    return countries
      .where((element){
        if(BlocProvider.of<LanguageCubit>(context).lang != 'ar'){
          return element.enName.toLowerCase().startsWith(value);
        }
        else{
          return element.arName.startsWith(value);
        }
      }).toList();
  }
}