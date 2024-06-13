import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tafweed/widgets/custom_button.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ResetPasswordScreen extends StatelessWidget {
  final String phone;
  const ResetPasswordScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/images/message.json",
                  width: 150,
                  repeat: false,
                ),
                Text(
                  AppLocalizations.of(context)!.new_password_sent_to_your_number + "\n$phone",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  )
                ),
                const SizedBox(height: 20,),
                CustomButton(
                  text: AppLocalizations.of(context)!.back_to_registration, 
                  onPressed: (){
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}