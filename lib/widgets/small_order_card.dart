import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/performer_requests/performer_requests_cubit.dart';
import 'package:tafweed/models/order.dart';

class SmallOrderCard extends StatelessWidget {

  final int index;
  const SmallOrderCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var performerReqCubit = BlocProvider.of<PerformerRequestsCubit>(context);
    return InkWell(
      onTap: (){
         Navigator.pushNamed(context, showOrderPath, arguments: index);
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                performerReqCubit.requests[index].name,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 30,),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 30,),
              Text(
                "النوع: ${performerReqCubit.requests[index].getType()}",
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}