import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/widgets/custom_button.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class OrderConfirmedScreen extends StatefulWidget {
  final Request request;
  const OrderConfirmedScreen({super.key, required this.request});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    var priceCubit = BlocProvider.of<PriceCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/images/confirmed.json",
                width: 150,
                repeat: false,
              ),
              Text(
                AppLocalizations.of(context)!.payment_successful,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                )
              ),
              const SizedBox(height: 30,),
              Material(
                borderRadius: BorderRadius.circular(6),
                elevation: 5,
                //shadowColor: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.transaction_code,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            )
                          ),
                          Text(
                            widget.request.paymentId.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              //fontSize: 16,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.price,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            )
                          ),
                          Text(
                            (double.parse(widget.request.paid!) * priceCubit.currency.rate).ceilToDouble().toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              //fontSize: 16,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            )
                          ),
                          Text(
                            widget.request.createdAt.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              //fontSize: 16,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.phone_number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            )
                          ),
                          Text(
                            Cache.getPhone().toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              //fontSize: 16,
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40,),
              CustomButton(
                text: AppLocalizations.of(context)!.done, 
                onPressed: (){
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}