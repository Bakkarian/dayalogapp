
import 'dart:math';

import 'package:dayalog/modals/OrdersModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/DarkThemeProvider.dart';
import '../services/CRUD.dart';
import '../styles/styles.dart';

class mainController extends GetxController{

  var apiKey = "AIzaSyDcWnFHx3aRBy_3oEeDMydOLGECc0MNYjk";
  var ordersList = <OrdersModel>[].obs;
  var isOrdersLoading = true.obs;

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

  //GET ORDERS
  getOrders() async{
    // isOrdersLoading(true);
    var orders = await dataManagement.getOrdersNew();
    try {
      if(orders!=null){
        ordersList.value = orders;
      }
    } finally {
      isOrdersLoading(false);
    }
  }

}