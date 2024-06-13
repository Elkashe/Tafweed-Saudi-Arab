import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/widgets/loading.dart';
import 'countries_info.dart';
import 'country_module.dart';


class CountriesScreen extends StatefulWidget {
  final Function(Country) onTap;
  const CountriesScreen({super.key, required this.onTap});

  @override
  State<CountriesScreen> createState() => _CountriesState();
}

class _CountriesState extends State<CountriesScreen> {
  List<Country> countries = [];
  List<Country> filteredCountries = [];
  bool isLoading = false;

  void getCounties() async{
    if(CountriesInfo.countries.isEmpty){
      setState(() {isLoading = true;});
      filteredCountries = countries = await CountriesInfo.getCountriesInfo(context);
      setState(() {isLoading = false;});
    }
    else{
      filteredCountries = countries = CountriesInfo.countries;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCounties();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: !isLoading ? Column(
            children: [
              TextField(
                onChanged: (value){
                  setState(() {
                    if(value.isEmpty){
                      filteredCountries = countries;
                    }
                    else{
                      filteredCountries 
                        = CountriesInfo.filterCountries(context, countries, value);
                    }
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600],),
                  hintText: AppLocalizations.of(context)!.search,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300
                    ), 
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, i){
                    return InkWell(
                      onTap: (){
                        widget.onTap(filteredCountries[i]);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CountryFlag.fromCountryCode(
                              filteredCountries[i].code,
                              height: 22,
                              width: 45,
                              borderRadius: 8,
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              BlocProvider.of<LanguageCubit>(context).lang == "ar" || BlocProvider.of<LanguageCubit>(context).lang == "ur"?
                              filteredCountries[i].arName : filteredCountries[i].enName, 
                              style: TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            Text(filteredCountries[i].dialCode, style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    );
                  }, 
                  separatorBuilder: (context, i){
                    return const SizedBox(height: 5,);
                  },
                  itemCount: filteredCountries.length,
                ),
              )
            ],
          ) : Center(child: Loading()),
        ),
      );
  }
}