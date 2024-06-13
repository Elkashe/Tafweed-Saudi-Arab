import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/requests/requests_cubit.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/list_loading.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/order_card.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class RequestsBody extends StatefulWidget {
  const RequestsBody({super.key});

  @override
  State<RequestsBody> createState() => _RequestsBodyState();
}

class _RequestsBodyState extends State<RequestsBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<RequestsCubit>(context).getRequests();
  }

  @override
  Widget build(BuildContext context) {
    var requestsCubit = BlocProvider.of<RequestsCubit>(context);
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        if(state is LoadingRequestsState){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListLoading(),
          );
        }
        else if(state is FailRequestsState){
          return Center(
            child: CustomButton(
              bgColor: Colors.red.shade700,
              onPressed: (){
                requestsCubit.getRequests();
              },
              text: AppLocalizations.of(context)!.retry_again,
            ),
          );
        }
        else{
          return Visibility(
            visible: requestsCubit.requests.isNotEmpty,
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
                  return RequestCard(request: requestsCubit.requests[i]);
                },
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: requestsCubit.requests.length,
              ),
            ),
          );
        }
      },
    );
  }
}
