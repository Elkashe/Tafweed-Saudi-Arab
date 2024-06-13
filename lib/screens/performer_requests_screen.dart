import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tafweed/cubits/performer_requests/performer_requests_cubit.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/small_order_card.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PerformerRequestsScreen extends StatefulWidget {
  const PerformerRequestsScreen({super.key});

  @override
  State<PerformerRequestsScreen> createState() =>
      _PerformerRequestsScreenState();
}

class _PerformerRequestsScreenState extends State<PerformerRequestsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PerformerRequestsCubit>(context).getRequests(context);
  }

  @override
  Widget build(BuildContext context) {
    var perfomerReqCubit = BlocProvider.of<PerformerRequestsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.requests),
      ),
      body: BlocBuilder<PerformerRequestsCubit, PerformerRequestsState>(
        builder: (context, state) {
          if(state is LoadingState){
            return const Center(child: Loading(),);
          }
          else if(state is FailState){
            return Center(
              child: CustomButton(
                bgColor: Colors.red.shade700,
                onPressed: (){
                  perfomerReqCubit.getRequests(context, true);
                },
                text: AppLocalizations.of(context)!.retry_again,
              ),
            );
          }
          else{
            return Visibility(
              visible: perfomerReqCubit.requests.isNotEmpty,
              replacement: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/images/request.json",
                      width: 350,
                    ),
                    Text(
                      AppLocalizations.of(context)!.no_requests_yet,
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  itemBuilder: (context, i) {
                    return SmallOrderCard(
                      index: i,
                    );
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: perfomerReqCubit.requests.length,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
