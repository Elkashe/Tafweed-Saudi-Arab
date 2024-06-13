import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tafweed/services/stripe_payment/stripe_keys.dart';

abstract class PaymentManager{
  static Future<String?> makePayment(double amount, String currency) async{
    try{
      var response = await _getClientSecret((amount * 100).toInt().toString(), currency);
      print("----> 1");
      await _initializePaymentSheet(response.data["client_secret"]);
      print("----> 2");
      var r = await Stripe.instance.presentPaymentSheet();
      print("#####################################################333");
      log("response ------> ${response.data}");
      return response.data["id"];
    }
    catch(e){
      print(e);
      return null;
    }
  }

    static Future<void> _initializePaymentSheet(String clientSecret)async{
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Tafweed",
      ),
    );
  }

  static Future<Response> _getClientSecret(String amount,String currency) async{
    Dio dio=Dio();
    print("$amount ----- $currency");
    var response= await Dio().post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        followRedirects: true,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          log(status.toString());
          return true; 
        },
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response;
  }
}