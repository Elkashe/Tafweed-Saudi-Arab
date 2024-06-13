import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/currency.dart';
import 'package:tafweed/services/dio/currency_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'price_state.dart';

class PriceCubit extends Cubit<PriceState> {
  late Currency currency;

  PriceCubit() : super(PriceInitial()){
    String code = Cache.getCurrencyCode() ?? "SAR";
    String sign = Cache.getCurrencySign() ?? "﷼";
    double rate = Cache.getCurrencyRate() ?? 1;
    currency = Currency(code, sign, rate: rate);
  }

  void changeCurrency(BuildContext context, Currency newCurrency) async{
    CurrencyServices().get(newCurrency.code).then((exchange){
      if(exchange != null){
        currency = newCurrency;
        currency.rate = exchange;
        Cache.setCurrencyCode(currency.code);
        Cache.setCurrencySign(currency.sign);
        Cache.setCurrencyRate(currency.rate);
        emit(CurrencyChangedState());
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.currency_changed, Colors.green));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.error_occurred_currency_not_changed, Colors.red));
      }
    });
  }

  void getCurrencyRate(BuildContext context) async{
    emit(LoadingState());
    CurrencyServices().get(currency.code).then((exchange){
      if(exchange != null){
        currency.rate = exchange;
        Cache.setCurrencyRate(currency.rate);
        emit(CurrencyChangedState());
      }
      else{
        emit(FailState());
      }
    });
  }
}
