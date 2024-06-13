import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderNotStartedScreen extends StatelessWidget {
  final String name;
  const OrderNotStartedScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text(
          "لم يبدأ بعد..",
          style: TextStyle(
            fontSize: 28,
            color: Colors.grey[800]
          ),
        ),
      ),
    );
  }
}