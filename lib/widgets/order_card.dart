// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/screens/track_screen.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class RequestCard extends StatelessWidget {
  final Request request;
  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    var priceCubit = BlocProvider.of<PriceCubit>(context);
    var lang = BlocProvider.of<LanguageCubit>(context).lang;
    return InkWell(
      onTap: (){
        if(request.doneDate != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrackScreen(request: request,)));
        }
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        //height: 120,
        decoration: BoxDecoration(
          color: request.doneDate != null ? Colors.green.shade600 : mainColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.request_number}: ${request.id}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Text(
                    request.package!.getName(lang),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      //height: 1
                    ),
                  ),
                ],
              ),
              Text(
                request.personName.toString(),
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              Text(
                "${request.getCreatedAt()}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                          request.doneDate != null ? 
                          AppLocalizations.of(context)!.done : AppLocalizations.of(context)!.did_not_started_yet,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //fontSize: 17,
                            color: request.doneDate != null ? Colors.green.shade800 : Colors.black,
                          ),
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
  }
}