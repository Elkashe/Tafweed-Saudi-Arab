import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/order/order_cubit.dart' as oc;
import 'package:tafweed/cubits/prices/price_cubit.dart' as p;
import 'package:tafweed/cubits/promo/promo_cubit.dart';
import 'package:tafweed/cubits/requests/requests_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/models/package.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/services/stripe_payment/payment_manager.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/order_row.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ReviewOrderScreen extends StatefulWidget {
  final Request request;
  const ReviewOrderScreen({super.key, required this.request});

  @override
  State<ReviewOrderScreen> createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //BlocProvider.of<p.PriceCubit>(context).getCurrencyRate(context);
  }

  @override
  Widget build(BuildContext context) {
    var orderCubit = BlocProvider.of<oc.OrderCubit>(context);
    var priceCubit = BlocProvider.of<p.PriceCubit>(context);
    var promoCubit = BlocProvider.of<PromoCubit>(context);
    var lang = BlocProvider.of<LanguageCubit>(context).lang;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.confirm_request),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<p.PriceCubit, p.PriceState>(
          builder: (context, state) {
            if(state is p.LoadingState){
              return Center(child: Loading(),);
            }
            else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OrderRow(
                    title: AppLocalizations.of(context)!.beneficiary_name,
                    value: widget.request.personName.toString(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OrderRow(
                    title: AppLocalizations.of(context)!.status,
                    value: widget.request.personCase!.getName(lang),
                  ),
                  if (widget.request.comment!.isNotEmpty)
                    const SizedBox(
                      height: 15,
                    ),
                  if (widget.request.comment!.isNotEmpty)
                    OrderRow(
                      title: AppLocalizations.of(context)!.comment,
                      value: widget.request.comment.toString(),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  OrderRow(
                    title: AppLocalizations.of(context)!.gender,
                    value: widget.request.gender == Gender.male ? 
                      AppLocalizations.of(context)!.male : AppLocalizations.of(context)!.female,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (double.parse(widget.request.discount!) != 0)
                    OrderRow(
                      title: AppLocalizations.of(context)!.before_discount,
                      value: "${priceCubit.currency.sign} ${widget.request.cost.toString()}",
                      valueColor: Colors.red.shade800,
                    ),
                    if (double.parse(widget.request.discount!) != 0)
                    const SizedBox(
                      height: 15,
                    ),
                  BlocBuilder<PromoCubit, PromoState>(
                      builder: (context, state) {
                    return OrderRow(
                      title: AppLocalizations.of(context)!.last_price,
                      value:
                          "${priceCubit.currency.sign} ${((double.parse(widget.request.paid!) * priceCubit.currency.rate).ceilToDouble()).toStringAsFixed(2)} ",
                      valueColor: Colors.green.shade600,
                    );
                  }),
                  Text("(${double.parse(widget.request.paid!) * (1 - promoCubit.percent)} ﷼)", style: TextStyle(color: Colors.grey),),
                  const SizedBox(
                    height: 30,
                  ),
                  // Row(
                  //   //mainAxisSize: MainAxisSize.min,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child: Form(
                  //         key: promoCubit.formKey,
                  //         child: CustomTextFormField(
                  //           text: AppLocalizations.of(context)!.discount_code,
                  //           onSaved: (value) {
                  //             promoCubit.promoCode = value.toString();
                  //           },
                  //           onValidate: (value) {
                  //             if (value!.isEmpty) {
                  //               return AppLocalizations.of(context)!
                  //                   .enter_discount_code;
                  //             }
                  //             return null;
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: CustomButton(
                  //         text: AppLocalizations.of(context)!.confirmation,
                  //         fontSize: 14,
                  //         onPressed: () async {
                  //           promoCubit.onSubmit(context);
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<oc.OrderCubit, oc.OrderState>(
                    builder: (context, state) {
                      if (state is oc.LoadingPayState) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Loading(),
                              SizedBox(
                                height: 5,
                              ),
                              Text(AppLocalizations.of(context)!
                                  .payment_in_progress),
                            ],
                          ),
                        );
                      } else {
                        return CustomButton(
                          text: AppLocalizations.of(context)!.pay_now,
                          onPressed: () async {
                            orderCubit.payNow(context, widget.request);
                          },
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
