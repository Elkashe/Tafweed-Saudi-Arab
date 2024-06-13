import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/cubits/requests/requests_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/coupon.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/models/person_cases.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/models/video.dart';
import 'package:tafweed/screens/order_confirmed_screen.dart';
import 'package:tafweed/screens/review_order_screen.dart';
import 'package:tafweed/services/dio/coupon_services.dart';
import 'package:tafweed/services/dio/person_cases_services.dart';
import 'package:tafweed/services/dio/request_services.dart';
import 'package:tafweed/services/fatoraah_payment/fatoraah.dart';
import 'package:tafweed/services/stripe_payment/payment_manager.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  Reason? current;
  late String name;
  String? comment;
  Gender gender = Gender.male;
  OrderType? orderType;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<PersonCase> cases = [];
  PersonCase? selectedCase;

  OrderCubit() : super(OrderInitial());

  void onNext(BuildContext context, Request request){
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      if(selectedCase != null){
        _createNewOrder(context, request);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.enter_status, Colors.red.shade600));
      }
    }
  }

  void payNow(BuildContext context, Request request){
    try{
      emit(LoadingPayState());
      request.paymentId = "1222222";
      RequestServices().addPayment(request).then((response){
        if(response != null){
          emit(SuccessPayState());
          request.createdAt = response.data["data"]["created_at"].split(".")[0];
          BlocProvider.of<RequestsCubit>(context).addRequest(request);
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmedScreen(request: request)));
        }
        else{
          emit(FailPayState());
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.payment_error, Colors.red));
        }
      });
    }
    catch(e){
      emit(FailPayState());
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.payment_error, Colors.red));
    }
  }

  void _createNewOrder(BuildContext context, Request request){
    try{
      emit(LoadingNewOrderState());
      RequestServices().requestWithoutPayment(request.toJson()).then((response){
        if(response != null){
          emit(SuccessNewOrderState());
          request.paid = response.data["data"]["paid"].toString();
          request.cost = response.data["data"]["cost"].toString();
          request.discount = response.data["data"]["discount"].toString();
          request.id = response.data["data"]["id"];
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewOrderScreen(request: request)));
        }
        else{
          emit(FailNewOrderState());
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red.shade600));
        }
      });
    }
    catch(e){
      print("error: $e");
      emit(FailNewOrderState());
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red.shade600));
    }
  }

  Future<Coupon?> checkCoupon(BuildContext context, String promoCode) async{
    try{
      var response = await CouponServices().get(promoCode);
      if(response != null){
        if(response.data["exists"]){
          _promoCodeConfirmed(context, double.parse(response.data["coupon"]["discount_percent"]));
          return Coupon.fromJson(response.data["coupon"]);
        }
        else{
          _promoCodeDenied(context);
          return null;
        }
      }
      else{
        _promoCodeDenied(context);
        return null;
      }
    }
    catch(e){
      _promoCodeDenied(context);
      return null;
    }
  }

   void _promoCodeConfirmed(BuildContext context, double percent){
    showDialog(
      context: context, 
      builder: (context){
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/confirmed.json',
                    width: 100,
                    repeat: false,
                  ),
                  //SizedBox(height: 20,),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: Scaffold(
                      body: Center(
                        child: Text(
                          "${AppLocalizations.of(context)!.you_got_discount} ${percent.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _promoCodeDenied(BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/wrong.json',
                    width: 100,
                    repeat: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void onConfirm(BuildContext context, double amount, String langCode) async{
  //   emit(LoadingState());
  //   PaymentManager.makePayment(amount.ceilToDouble(), "SAR").then((paymentId) {
  //     print(paymentId);
  //     if(paymentId != null){
  //       try{
  //         Order order = Order(name: name, reason: current!, price: amount, comment: comment, 
  //           type: orderType, gender: gender, payment: paymentId, createdAt: DateTime.now());
  //         String token = Cache.getToken()!;
  //         print(order.toMap());
  //         print(token);
  //         RequestServices().post(order.toMap(), token).then((value){
  //           emit(SuccessState());
  //           BlocProvider.of<RequestsCubit>(context).addOrder(context, order);
  //           Navigator.pushNamed(context, orderConfirmedPath, arguments: order);
  //         });
  //       }
  //       catch(e){
  //         print(e);
  //       }
  //     }
  //     else{
  //       emit(FailState());
  //       ScaffoldMessenger.of(context).showSnackBar(customSnackBar("عملية الدفع لم تتم", Colors.red.shade600));
  //     }
  //   });

  //   //Payment fatoraah
  //   print("amount: $amount");
  //   String? paymentId = await Fatoraah.pay(
  //     context, 
  //     amount, 
  //     customerName: Cache.getName(), 
  //     customerMobile: Cache.getPhone(), 
  //     language: langCode == "ar"? ApiLanguage.Arabic : ApiLanguage.English,
  //   );
  //   if(paymentId != null){
  //     Order order = Order(name: name, reason: current!, price: amount, comment: comment, 
  //     type: orderType, gender: gender, payment: paymentId, createdAt: DateTime.now());
  //     String token = Cache.getToken()!;
  //     print(order.toMap());
  //     print(token);
  //     RequestServices().post(order.toMap(), token).then((value){
  //       emit(SuccessState());
  //       BlocProvider.of<RequestsCubit>(context).addOrder(context, order);
  //       Navigator.pushNamed(context, orderConfirmedPath, arguments: order);
  //     });
  //   }
  //   else{
  //     emit(FailState());
  //     if(context.mounted){
  //       ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.payment_error, Colors.red.shade600));
  //     }
  //   }
  // }

  String getStatus(BuildContext context){
    switch(current){
      case Reason.sick: return AppLocalizations.of(context)!.sick;
      case Reason.old: return AppLocalizations.of(context)!.disabled;
      case Reason.died: return AppLocalizations.of(context)!.deceased;
      case Reason.other: return AppLocalizations.of(context)!.other;
      default: return AppLocalizations.of(context)!.status;
    }
  }

  void setGender(Gender value){
    gender = value;
    emit(GenderChanged());
  }

  String getGender(BuildContext context){
    switch(gender){
      case Gender.male: return AppLocalizations.of(context)!.male;
      case Gender.female: return AppLocalizations.of(context)!.female;
    }
  }

  void getPersonCases(String langCode){
    if(cases.isNotEmpty) return;
    try{
      emit(LoadingPersonCasesState());
      PersonCasesServices().get().then((response){
        if(response != null){
          for(var pCase in response.data["personCases"]){
            cases.add(
              PersonCase.fromJson(pCase)
            );
          }
          emit(SuccessPersonCasesState());
        }
        else{
          throw();
        }
      });
    }
    catch(e){
      emit(FailPersonCasesState());
    }
  }

  void selectPersonCase(PersonCase value){
    selectedCase = value;
    emit(CaseSelectedState());
  }

  // void showStatus(BuildContext context){
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //     context: context, 
  //     builder: (context){
  //       return Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CustomButton(
  //               bgColor: current == Reason.sick ? mainColor : Colors.grey,
  //               text: AppLocalizations.of(context)!.sick, 
  //               onPressed: (){
  //                 current = Reason.sick;
  //                 emit(StatusChanged());
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             const SizedBox(height: 5,),
  //             CustomButton(
  //               bgColor: current == Reason.old ? mainColor : Colors.grey,
  //               text: AppLocalizations.of(context)!.disabled, 
  //               onPressed: (){
  //                 current = Reason.old;
  //                 emit(StatusChanged());
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             const SizedBox(height: 5,),
  //             CustomButton(
  //               bgColor: current == Reason.died ? mainColor : Colors.grey,
  //               text: AppLocalizations.of(context)!.deceased, 
  //               onPressed: (){
  //                 current = Reason.died;
  //                 emit(StatusChanged());
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             const SizedBox(height: 5,),
  //             CustomButton(
  //               bgColor: current == Reason.other ? mainColor : Colors.grey,
  //               text: AppLocalizations.of(context)!.other, 
  //               onPressed: (){
  //                 current = Reason.other;
  //                 emit(StatusChanged());
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
