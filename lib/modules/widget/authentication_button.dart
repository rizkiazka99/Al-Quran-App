import 'package:alquranapp/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;

  const AuthenticationButton({
    Key? key, 
    required this.onPressed, 
    required this.buttonText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.lato(
              fontSize: 20, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationTextButton extends StatelessWidget {
  final void Function() onTap;
  final String buttonText;

  const AuthenticationTextButton({
    Key? key, 
    required this.onTap, 
    required this.buttonText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Text(
          buttonText,
          style: GoogleFonts.lato(
              fontSize: 15, 
              fontWeight: FontWeight.bold, 
              color: contextBlue
            ),
        ),
      ),
    );
  }
}