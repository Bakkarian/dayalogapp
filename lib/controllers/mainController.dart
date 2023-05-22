
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/DarkThemeProvider.dart';
import '../styles/styles.dart';

class mainController extends GetxController{

  var apiKey = "AIzaSyDcWnFHx3aRBy_3oEeDMydOLGECc0MNYjk";

  //Generate random string
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  var userString = "".obs;

  @override
  void onInit(){
    super.onInit();
  }

//GLOBAL FUNCTIONS
  hideKeyboard(context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

}