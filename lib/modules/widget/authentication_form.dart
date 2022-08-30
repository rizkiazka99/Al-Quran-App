import 'package:alquranapp/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationForm extends StatefulWidget {
  final Key formKey;
  final AutovalidateMode autovalidateMode;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final Color focusedColor;

  const AuthenticationForm({
    Key? key, 
    required this.formKey, 
    required this.autovalidateMode,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator, 
    this.suffixIcon,
    this.focusedColor = Colors.black
  }) : super(key: key);

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {


  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.lato(color: textGrey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: widget.focusedColor, 
              width: 2.0
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: widget.focusedColor, width: 2.0
            )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: contextRed, 
              width: 2.0
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: contextRed, 
              width: 2.0
            )
          ),
          suffixIcon: widget.suffixIcon
        ),
        validator: widget.validator
      )
    );
  }
}
