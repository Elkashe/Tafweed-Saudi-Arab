import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/order/order_cubit.dart';
import 'package:tafweed/cubits/performer_requests/performer_requests_cubit.dart' as pr;
import 'package:tafweed/models/order.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/order_row.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ShowOrderScreen extends StatelessWidget {
  final int index;
  const ShowOrderScreen({super.key, required this.index,});

  @override
  Widget build(BuildContext context) {
    var performerReqCubit = BlocProvider.of<pr.PerformerRequestsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.personal_information),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            OrderRow(
              title: AppLocalizations.of(context)!.beneficiary_name, 
              value: performerReqCubit.requests[index].name,
            ),
            const SizedBox(height: 15,),
            OrderRow(
              title: AppLocalizations.of(context)!.status, 
              value: performerReqCubit.requests[index].getReason(),
            ),
            if(performerReqCubit.requests[index].comment != null)
              const SizedBox(height: 15,),
            if(performerReqCubit.requests[index].comment != null)
              OrderRow(
                title: AppLocalizations.of(context)!.comment, 
                value: performerReqCubit.requests[index].comment!,
              ),
            const SizedBox(height: 15,),
            OrderRow(
              title: AppLocalizations.of(context)!.gender, 
              value: performerReqCubit.requests[index].getGender(),
            ),
            const SizedBox(height: 30,),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if(state is LoadingState){
                  return const Center(
                    child: Loading(),
                  );
                }
                else{
                  return CustomButton(
                    text: AppLocalizations.of(context)!.next_step,
                    onPressed: () {
                      Navigator.pushNamed(context, videosSubmissionPath, arguments: index);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}