import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';

class LangDropDown extends StatefulWidget {
  const LangDropDown({super.key});

  @override
  State<LangDropDown> createState() => _LangDropDownState();
}

class _LangDropDownState extends State<LangDropDown> {
List<String> items = ["SA", "US", "TR", "ID", "IN"];
List<String> languages = ["عربي", "English", "Turkish", "Indonesian", "اردو"];
List<String> languagesCodes = ["ar", "en", "tr", "id", "ur"];
String? selectedValue;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButton2<String>(
        iconStyleData: IconStyleData(
          icon: SizedBox.shrink(),
        ),
        underline: SizedBox.shrink(),
        isExpanded: true,
        hint: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language),
            //SizedBox(width: 5,),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        items: <DropdownMenuItem<String>>[
          for(int i=0; i<items.length; i++)
            DropdownMenuItem<String>(
              value: items[i],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CountryFlag.fromCountryCode(
                    items[i],
                    height: 12,
                    width: 25,
                    borderRadius: 15,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    languages[i],
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
        ],
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
          BlocProvider.of<LanguageCubit>(context).changeLanguage(languagesCodes[items.indexOf(value!)]);
        },
        buttonStyleData: const ButtonStyleData(
          //padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 100,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownStyleData: DropdownStyleData(
          elevation: 4,
          width: 150,
        ),
      ),
    ),
  );
}
}