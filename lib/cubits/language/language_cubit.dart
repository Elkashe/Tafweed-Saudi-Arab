import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/local/cache.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  late String lang;

  LanguageCubit() : super(LanguageInitial()){
    var savedLang = Cache.getLanguage();
    if(savedLang != null){
      lang = savedLang;
    }
    else{
      List<String> ourLanguages = ["ar", "en", "id", "tr", "ur"];
      String platformLang = Platform.localeName.split("_").first.toLowerCase();
      if(ourLanguages.contains(platformLang)){
        lang = platformLang;
      }
      else{
        lang = "en";
      }
    }
  }

  void changeLanguage(String langCode){
    lang = langCode;
    Cache.setLanguage(langCode);
    emit(LangChangedState());
  }

  
  void showLanguageBottomSheet(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Colors.white,
      //isScrollControlled: true,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  BlocProvider.of<LanguageCubit>(context).changeLanguage("ar");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        "SA",
                        width: 50,
                        height: 25,
                        borderRadius: 15,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "عربي",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey[200],),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  BlocProvider.of<LanguageCubit>(context).changeLanguage("en");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        "US",
                        width: 50,
                        height: 25,
                        borderRadius: 15,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "English",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey[200],),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  BlocProvider.of<LanguageCubit>(context).changeLanguage("tr");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        "TR",
                        width: 50,
                        height: 25,
                        borderRadius: 15,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Turkish",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey[200],),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  BlocProvider.of<LanguageCubit>(context).changeLanguage("id");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        "ID",
                        width: 50,
                        height: 25,
                        borderRadius: 15,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Indonisian",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
              Divider( color: Colors.grey[200],),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  BlocProvider.of<LanguageCubit>(context).changeLanguage("ur");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        "IN",
                        width: 50,
                        height: 25,
                        borderRadius: 15,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "أردو",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
