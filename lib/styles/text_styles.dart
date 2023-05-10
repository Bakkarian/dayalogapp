import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mainController.dart';
import './colors.dart';

const String fontName = 'OpenSans';
FontWeight headingWeight = FontWeight.w700;
double h1Size = 35.0;
double h2Size = 30.0;
double h3Size = 25.0;
double h4Size = 21.0;
double h5Size = 16.0;
double h6Size = 12.0;
double pSize = 15.0;

mainController _controller = Get.find();

const TitleTextStyle = TextStyle(
    fontFamily: fontName
);
const Body1TextStyle = TextStyle(
    fontFamily: fontName,
//    height: 1
);

TextStyle h1 = TextStyle(
  color: primaryHeadingColor,
  fontWeight: headingWeight,
  fontSize: h1Size,
    fontFamily: fontName
);
TextStyle h2 = TextStyle(
  color: primaryHeadingColor,
  fontWeight: headingWeight,
  fontSize: h2Size,
  fontFamily: fontName
);
TextStyle h3 = TextStyle(
  color: primaryHeadingColor,
  fontWeight: headingWeight,
  fontSize: h3Size,
  fontFamily: fontName
);
TextStyle h4 = TextStyle(
  color: primaryHeadingColor,
  fontWeight: headingWeight,
  fontSize: h4Size,
  fontFamily: fontName
);
TextStyle h5 = TextStyle(
  color: primaryHeadingColor,
  fontWeight: headingWeight,
  fontSize: h5Size,
  fontFamily: fontName
);
TextStyle h6 = TextStyle(
  color: primaryHeadingColor,
  fontWeight: headingWeight,
  fontSize: h6Size,
  fontFamily: fontName
);
TextStyle p = TextStyle(
    color: primaryTextColor,
    fontFamily: fontName,
    fontSize: pSize
//  fontSize: 12,
);
TextStyle button = TextStyle(
    fontFamily: fontName,
);