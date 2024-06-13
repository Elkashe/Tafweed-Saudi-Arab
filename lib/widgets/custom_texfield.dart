import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;
  final void Function(String?) onSaved;
  final String? Function(String?)? onValidate;
  final int maxLines;
  final TextInputType keyboardType;
  final String? initial;
  final Widget? prefix;
  final String? suffixText;
  final bool obscureText;
  final String? hintText;
  const CustomTextFormField({super.key, required this.text, required this.onSaved, this.maxLines = 1, this.onValidate, this.keyboardType = TextInputType.text, this.initial, this.prefix, this.suffixText, this.obscureText = false, this.hintText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool visible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: mainColor,
      obscureText: visible,
      initialValue: widget.initial,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      style: TextStyle(
        color: Colors.grey[900],
        fontSize: 14,
        height: 2
      ),
      obscuringCharacter: '*',
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        suffixText: widget.suffixText,
        suffixIcon: widget.obscureText == true ? IconButton(
          onPressed: (){
            setState(() {
              visible = !visible;
            });
          },
          icon: Icon(visible ? Icons.visibility_off : Icons.visibility, color: Colors.grey, size: 20,),
        ) : null,
        filled: true,
        fillColor: secondColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
        hintText: widget.hintText,
        labelText: widget.text,
        labelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        
        // enabledBorder: InputBorder.none,
        // focusedBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.grey.shade300
          ), 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.grey.shade300
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.red.shade300
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.red.shade300
          ),
        ),
      ),
      onSaved: widget.onSaved,
      validator: widget.onValidate,
    );
  }
}
