
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:tafweed/services/fatoraah_payment/fatoraah.dart';
import 'package:tafweed/services/stripe_payment/payment_manager.dart';

const String apiKey =
    "znynNWduHsVA1HGzjqisYQCUb9Yj66phKgIBHFfOyYFcsdJhXiJJRmvhHmDWRfNGRPbUL82JQbdIBGCsVYPWHrBZYwoP2FUFnkxoBWlf8mf3ecY_x1j32nb7_C17Vo_8xdWX";

// ignore: unused_local_variable

class FatoraahScreen extends StatefulWidget {
  const FatoraahScreen({super.key});

  @override
  State<FatoraahScreen> createState() => _MyAppState();
}

class _MyAppState extends State<FatoraahScreen> {
  initiatePayment() async {
    MFInitiatePaymentRequest request = MFInitiatePaymentRequest(
        invoiceAmount: 10, currencyIso: MFCurrencyISO.KUWAIT_KWD);
    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) => debugPrint("tmam: ${value.toString()}"))
        .catchError((error) => {debugPrint("error: ${error.message}")});
  }

  executePayment() async {
    MFExecutePaymentRequest request = MFExecutePaymentRequest(invoiceValue: 10, );
    request.paymentMethodId = 1;
    var response = await MFSDK
        .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
          debugPrint("invoiceId ::::: $invoiceId");
        })
        .then((value) => debugPrint("executePayment Done ::: ${value.toString()}"))
        .catchError((error) => {debugPrint("executePayment error :::${error.message}")});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 1,
          //   title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: TextButton(
                onPressed: () async{
                  try{
                    MFSDK.init(apiKey, MFCountry.KUWAIT, MFEnvironment.LIVE);
                    initiatePayment();
                    executePayment();
                    // var response = await MyFatoorah.startPayment(
                    //   context: context,
                    //   request: MyfatoorahRequest.live(
                    //     currencyIso: Country.SaudiArabia,
                    //     successUrl: 'https://www.facebook.com',
                    //     errorUrl: 'https://www.google.com/',
                    //     invoiceAmount: 1,
                    //     language: ApiLanguage.Arabic,
                    //     token: "znynNWduHsVA1HGzjqisYQCUb9Yj66phKgIBHFfOyYFcsdJhXiJJRmvhHmDWRfNGRPbUL82JQbdIBGCsVYPWHrBZYwoP2FUFnkxoBWlf8mf3ecY_x1j32nb7_C17Vo_8xdWX",
                    //   ),
                    // );
                    // log(response.paymentId.toString());
                  }
                  catch(e){
                    print("error payment: ${e.toString()}");
                  }
                },
                child: Text("Try"),
              ),
            ),
          ),
        ),
      );
  }
}
