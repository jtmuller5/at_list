import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.cyan,
  accentColor: Colors.orange,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange
  )
);


ThemeData darkTheme = ThemeData(
  primaryColor: Colors.black,
  accentColor: Colors.lightGreenAccent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightGreenAccent
    )
);

TextStyle get attachedStyle{
  return GoogleFonts.caveat(
      textStyle: TextStyle(
        fontSize: 36,
        //color: Colors.red
      ));
}

InputDecoration get attachedInput {
  return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      filled: true,
      fillColor: Colors.grey.shade300,
      focusColor: Colors.red,
      hintStyle: TextStyle(color: Colors.red.shade300));
}