import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tafweed/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: mainColor,
      size: 25.0,
      duration: Duration(milliseconds: 2000),
    );
  }
}