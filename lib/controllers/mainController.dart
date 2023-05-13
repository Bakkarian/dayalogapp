
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/DarkThemeProvider.dart';
import '../styles/styles.dart';

class mainController extends GetxController{

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