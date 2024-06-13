import 'package:flutter/material.dart';
import 'package:tafweed/constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final Color bgColor;
  final double fontSize;
  const CustomButton({super.key, required this.text, required this.onPressed, this.bgColor = mainColor, this.fontSize = 18});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor,
          foregroundColor: secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ), 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}