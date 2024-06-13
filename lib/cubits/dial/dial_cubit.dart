import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/packages/country_code/country_module.dart';

part 'dial_state.dart';

class DialCubit extends Cubit<DialState> {
  Country? country;
  DialCubit() : super(DialInitial()){
    String? dialCode = Cache.getDialCode();
    String? countryEnName = Cache.getCountryEnName();
    String? countryArName = Cache.getCountryArName();
    int? id = Cache.getCountryId();
    if(dialCode != null && countryEnName != null){
      country = Country(id!, countryEnName, countryArName!, dialCode.split("/").first, dialCode.split("/").last);
    }
  }

  void changeCountry(Country value){
    country = value;
    Cache.setDialCode("${value.code}/${value.dialCode}");
    Cache.setCountryArName(value.arName);
    Cache.setCountryEnName(value.enName);
    Cache.setCountryId(value.id);
    emit(ChangeCountryState());
  }
}
