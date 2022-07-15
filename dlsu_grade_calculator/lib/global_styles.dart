import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLORS
Color primaryColor = const Color(0xFF009751);
Color secondaryColor = const Color(0xFF00FF89);
Color tertiaryColor = const Color(0xFF004A27);

Color primaryTextColor = const Color(0xFF101213);
Color secondaryTextColor = const Color(0xFF57636C);

Color containerBG = const Color(0xFFEEEEEE);

//TEXT STYLES
TextStyle primaryStyle(double fontSize, Color? fontColor, FontWeight? weight) {
  fontColor ??= primaryTextColor;
  weight ??= FontWeight.w600;
  return GoogleFonts.montserrat(
      textStyle:
          TextStyle(color: fontColor, fontSize: fontSize, fontWeight: weight));
}

TextStyle secondaryStyle(
    double? fontSize, Color? fontColor, FontWeight? weight) {
  fontSize ??= 16;
  fontColor ??= primaryTextColor;
  weight ??= FontWeight.w400;
  return GoogleFonts.roboto(
      textStyle:
          TextStyle(color: fontColor, fontSize: fontSize, fontWeight: weight));
}
