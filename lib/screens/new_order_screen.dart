import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/order/order_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/models/coupon.dart';
import 'package:tafweed/models/package.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_texfield.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tafweed/widgets/loading.dart';

class NewOrderScreen extends StatefulWidget {
  final Package package;
  const NewOrderScreen({super.key, required this.package});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  Request newRequest = Request();
  GlobalKey<FormState> _promoCodeKey = GlobalKey<FormState>();
  String? promoCode;

  @override
  void initState() {
    super.initState();
    var langCubit = BlocProvider.of<LanguageCubit>(context);
    BlocProvider.of<OrderCubit>(context).getPersonCases(langCubit.lang);
  }

  @override
  Widget build(BuildContext context) {
    var lang = BlocProvider.of<LanguageCubit>(context).lang;
    var orderCubit = BlocProvider.of<OrderCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.new_request),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: orderCubit.formKey,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!
                    .enter_personal_data_of_the_person_for_whom_umrah_will_be_completed,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                text: AppLocalizations.of(context)!.full_name,
                onSaved: (value) {
                  newRequest.personName = value;
                },
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.enter_full_name;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () {
                  _showStatus(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade300,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        return Text(
                          orderCubit.selectedCase?.getName(lang).toString() ??
                              AppLocalizations.of(context)!.status,
                          style: TextStyle(
                            color: orderCubit.current == null
                                ? Colors.grey[700]
                                : mainColor,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                text: AppLocalizations.of(context)!.additional_comment,
                onSaved: (value) {
                  newRequest.comment = value;
                },
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.gender,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      return Radio(
                        value: Gender.male,
                        groupValue: orderCubit.gender,
                        activeColor: mainColor,
                        onChanged: (value) {
                          orderCubit.setGender(value!);
                          newRequest.gender = value;
                        },
                      );
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.male,
                    style: TextStyle(
                      fontSize: 17,
                      //color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      return Radio(
                        value: Gender.female,
                        groupValue: orderCubit.gender,
                        activeColor: mainColor,
                        onChanged: (value) {
                          orderCubit.setGender(value!);
                          newRequest.gender = value;
                        },
                      );
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.female,
                    style: TextStyle(
                      fontSize: 17,
                      //color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Form(
                      key: _promoCodeKey,
                      child: CustomTextFormField(
                        text: AppLocalizations.of(context)!.discount_code,
                        onSaved: (value) {
                          promoCode = value.toString();
                        },
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_discount_code;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 47,
                      child: CustomButton(
                        bgColor: Colors.green.shade600,
                        text: AppLocalizations.of(context)!.confirmation,
                        fontSize: 14,
                        onPressed: () async {
                          _promoCodeKey.currentState?.save();
                          newRequest.coupon =
                              await orderCubit.checkCoupon(context, promoCode!);
                              print(newRequest.coupon);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is LoadingNewOrderState) {
                    return Center(
                      child: Loading(),
                    );
                  } else {
                    return CustomButton(
                      text: AppLocalizations.of(context)!.next_step,
                      onPressed: () {
                        newRequest.package = widget.package;
                        orderCubit.onNext(context, newRequest);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatus(BuildContext context) {
    var orderCubit = BlocProvider.of<OrderCubit>(context);
    var langCubit = BlocProvider.of<LanguageCubit>(context);
    orderCubit.getPersonCases(langCubit.lang);
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state is LoadingPersonCasesState) {
                return Center(
                  child: Loading(),
                );
              } else if (state is FailPersonCasesState) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      orderCubit.getPersonCases(langCubit.lang);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.retry_again,
                      style: TextStyle(
                        fontSize: 18,
                        color: mainColor,
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < orderCubit.cases.length; i++)
                      Column(
                        children: [
                          CustomButton(
                            bgColor:
                                orderCubit.selectedCase == orderCubit.cases[i]
                                    ? mainColor
                                    : Colors.grey,
                            text: orderCubit.cases[i].getName(langCubit.lang),
                            onPressed: () {
                              orderCubit.selectPersonCase(orderCubit.cases[i]);
                              newRequest.personCase = orderCubit.cases[i];
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}
