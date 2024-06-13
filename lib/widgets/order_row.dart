import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/cubits/order/order_cubit.dart';

class OrderRow extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  const OrderRow({super.key, required this.title, required this.value, this.valueColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[100],
          ),
        ),
        const SizedBox(width: 15,),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            //fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}