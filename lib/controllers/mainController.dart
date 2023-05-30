
import 'dart:async';
import 'dart:math';

import 'package:dayalog/modals/OrdersModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

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


  late StreamSubscription _sub;
  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.\
      if(initialLink==null){
        Get.offAllNamed("/mainPage");
      }else{
        handleLinks(initialLink);
      }
      // Attach a listener to the stream
      _sub = linkStream.listen((String? link) {
        // Parse the link and warn the user, if it is not correct
        print("INNN: $link");
        if(link==null){
          Get.offAllNamed("/mainPage");
        }else{
          handleLinks(link);
        }
      }, onError: (err) {
        // Handle exception by warning the user their action did not succeed
      });
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }

  }

  handleLinks(link){
    var initUri = Uri.parse(link);
    print("INNNN: ${initUri.path}");
    var path = initUri.path;
    Get.offAllNamed("/mainPage");
    if(path!=""||path!="/"){
      if(path=="/create_order"){
        Get.toNamed("/sendOrder");
      }
      if(path=="/view_order"){
        Get.toNamed("/viewOrders");
      }
    }
  }

}