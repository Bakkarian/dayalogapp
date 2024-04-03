
import 'dart:ui';

import 'package:dayalog/styles/colors.dart';
import 'package:flutter/material.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      // primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.black : primaryColor,

      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF4F4F4),

      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : primaryColor,
      shadowColor: isDarkTheme ? Colors.black : Colors.grey[200],

      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),

      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),

      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: ButtonThemeData(
            buttonColor: isDarkTheme ? Color(0xff3B3B3B) : primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0),
            ),
            textTheme: ButtonTextTheme.accent
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(

            )
        ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkTheme ? Colors.black : Color(0XffFFFFFF),
        titleTextStyle: TextStyle(
            // fontFamily: fontName,
            color: isDarkTheme ? const Color(0XffFFFFFF) : const Color(0Xff2960FF),
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),
      textTheme: TextTheme(
          bodyLarge: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
          // fontWeight: FontWeight.bold,
            fontSize: 24
        ),
        bodySmall: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            // fontWeight: FontWeight.bold,
            fontSize: 14
        ),
        bodyMedium: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            // fontWeight: FontWeight.bold,
            fontSize: 16
        ),
      ),
      fontFamily: "ahronbd"
    );

  }
}

