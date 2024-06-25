import 'dart:io';

import 'package:dayalog/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mainController.dart';
import 'colors.dart';
import 'text_styles.dart';

const double smallRadious = 8.0;
const double mediumRadious = 12.0;
const double bigRadious = 18.0;
mainController _controller = Get.put(mainController());
var isDarkMode = _controller.themeChangeProvider.darkTheme;


final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  // onPrimary: white,
  backgroundColor: primaryColor,
  textStyle: TextStyle(
    color: white
  ),
  // minimumSize: Size(88, 36),
  // padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

final ButtonStyle primaryOutlineButtonStyle = OutlinedButton.styleFrom(
  // primary: Colors.black87,
  foregroundColor: primaryColor, shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
).copyWith(
  side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(
          color: accentColor,
          width: 1,
        );
      }else{
        return BorderSide(
          color: primaryColor,
          width: 1,
        );
      }
    },
  ),
);

final ButtonStyle accentOutlineButtonStyle = OutlinedButton.styleFrom(
  // primary: Colors.black87,
  foregroundColor: accentColor, shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
).copyWith(
  side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(
          color: primaryColor,
          width: 1,
        );
      }else{
        return BorderSide(
          color: accentColor,
          width: 1,
        );
      }
    },
  ),
);

final ButtonStyle whiteOutlineButtonStyle = OutlinedButton.styleFrom(
  // primary: Colors.black87,
  foregroundColor: white, shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
).copyWith(
  side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(
          color: white,
          width: 1,
        );
      }else{
        return BorderSide(
          color: white,
          width: 1,
        );
      }
    },
  ),
);

final ButtonStyle primaryButton = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(15.0),
    ),
    disabledBackgroundColor: veryLightGrey,
    disabledForegroundColor: grey,
    backgroundColor: Styles.themeData(_controller.themeChangeProvider.darkTheme, Get.context!).primaryColor,
    foregroundColor: white,
    textStyle: TextStyle(
        color: white,
      fontWeight: FontWeight.bold
    )
);

final ButtonStyle accentButton = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(15.0),
    ),
    disabledBackgroundColor: veryLightGrey,
    backgroundColor: accentColor,
    foregroundColor: white,
    textStyle: TextStyle(
        color: white,
        fontWeight: FontWeight.bold
    )
);

final ButtonStyle greenButton = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(15.0),
//                      side: BorderSide(color: white)
    ),
    disabledBackgroundColor: veryLightGrey,
    backgroundColor: green,
    foregroundColor: white,
    textStyle: TextStyle(
        color: white
    )
);

final ButtonStyle redButton = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(15.0),
//                      side: BorderSide(color: white)
    ),
    disabledBackgroundColor: veryLightGrey,
    backgroundColor: red,
    foregroundColor: white,
    textStyle: TextStyle(
        color: white
    )
);

final ButtonStyle whiteButton = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(15.0),
//                      side: BorderSide(color: white)
    ),
    disabledBackgroundColor: veryLightGrey,
    backgroundColor: white,
    foregroundColor: primaryColor,
    textStyle: TextStyle(
        color: white,
      fontWeight: FontWeight.bold
    )
);