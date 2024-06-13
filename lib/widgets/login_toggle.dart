import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/login/login_cubit.dart';

class LoginToggle extends StatefulWidget {
  const LoginToggle({super.key});

  @override
  State<LoginToggle> createState() => _LoginToggleState();
}

class _LoginToggleState extends State<LoginToggle> {
  bool noraml = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: (){
        BlocProvider.of<LoginCubit>(context).togglePage();
        setState(() {
          noraml = !noraml;
        });
      },
      child: Container(
        width: 60,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.bounceOut,
              alignment: noraml ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 30,
                height: 26,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.person,size: 15, color: noraml ?  Colors.white : Colors.black,),
                  //Icon(Icons.home_rounded, size: 15, color: noraml ? Colors.black : Colors.white,),
                  Text(
                    "🕋",
                    style: TextStyle(
                      fontSize: 12
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}