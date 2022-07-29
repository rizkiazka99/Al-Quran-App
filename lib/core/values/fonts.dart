import 'package:alquranapp/core/values/colors.dart';
import 'package:flutter/material.dart';

const textPrimaryBold =
    TextStyle(color: primaryColor, fontWeight: FontWeight.bold);
dynamic textWarningBold =
    TextStyle(color: warningColor, fontWeight: FontWeight.bold);
dynamic textSuccessBold =
    TextStyle(color: successColor, fontWeight: FontWeight.bold);
const textPrimaryReguler =
    TextStyle(color: primaryColor, fontWeight: FontWeight.normal);
const textPrimaryLight =
    TextStyle(color: primaryColor, fontWeight: FontWeight.w300);
const textBlackBold =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
const textDangerReguler = TextStyle(color: Colors.red);
const textBlackReguler = TextStyle(color: Colors.black);
const textWhite = TextStyle(color: Colors.white);
const textGray = TextStyle(color: Colors.grey);

//headline
h1({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 40);
}

h2({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 28);
}

h3({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24);
}

h4({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20);
}

h4_5({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18);
}

h5({color: textBlack, fontWeight: FontWeight.bold}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 16);
}

h6({color: textBlack, fontWeight: FontWeight.bold}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 14);
}

h7({color: textBlack, fontWeight: FontWeight.bold}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 12);
}

//body
bodyLg({color: textBlack}) {
  return TextStyle(color: color, fontSize: 16, letterSpacing: 2);
}

bodyMd({color: textGrey, fontWeight: FontWeight.normal}) {
  return TextStyle(color: color, fontSize: 14, fontWeight: fontWeight);
}

bodySm({color: textBlack, fontWeight: FontWeight.normal}) {
  return TextStyle(color: color, fontSize: 12, fontWeight: fontWeight);
}

bodyXs({color: textBlack}) {
  return TextStyle(color: color, fontSize: 10);
}

bodyXsGrey({color: textGrey, fontSize}) {
  return TextStyle(color: color, fontSize: fontSize);
}
//button
buttonLg({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16);
}

buttonMd({color: textBlack, fontWeight: FontWeight.bold}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 14);
}

buttonSm({color: textBlack}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12);
}

//text button
txtButtonMd({color: textOrange}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14);
}

txtButtonSm({color: textOrange}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12);
}
