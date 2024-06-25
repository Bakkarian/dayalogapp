
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dayalog/modals/OrdersModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni_links/uni_links.dart';

import '../modals/DarkThemeProvider.dart';
import '../services/CRUD.dart';
import '../styles/styles.dart';

class mainController extends GetxController{

  var apiKey = "AIzaSyAir29_hRhb99ll83YjLarlSbj-9su5zXI";
  var ordersList = <OrdersModel>[].obs;
  var isOrdersLoading = true.obs;
  var token;
  var devices = [].obs;
  var parkedDevices = 0.obs;
  List<LatLng> stops = [];

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
    getDevices();
  }


//GLOBAL FUNCTIONS
  hideKeyboard(context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }
  void setCurrentAppTheme() async {
    await themeChangeProvider.darkThemePreference.setDarkTheme(true);
    getCurrentAppTheme();
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

  late Timer _timer;
  getDevices() async{
    dataManagement().getDevices().then((results){
      devices.clear();
      devices.addAll(jsonDecode(results)["data"]);
      debugPrint("$devices");
      _timer = new Timer.periodic(const Duration(seconds: 10), (timer){
        getDevices();
        _timer.cancel();
      });

      parkedDevices.value=0;
      devices.forEach((item){
        if (item["motionstate"]==0) {
          parkedDevices.value += 1;
        }
      });
    });

  }

  List<Location> detectStops(List<Location> locations, {double stopDistanceThreshold = 10, int stopDurationThreshold = 30}) {
    List<Location> stops = [];

    if (locations.isEmpty) return stops;

    Location? currentStopStart;
    int stopDuration = 0;

    for (int i = 1; i < locations.length; i++) {
      double distance = Geolocator.distanceBetween(
          locations[i-1].latitude, locations[i-1].longitude,
          locations[i].latitude, locations[i].longitude
      );

      if (distance < stopDistanceThreshold) {
        if (currentStopStart == null) {
          currentStopStart = locations[i-1];
          stopDuration = 0;
        }
        stopDuration += locations[i].timestamp.difference(locations[i-1].timestamp).inSeconds;
      } else {
        if (currentStopStart != null && stopDuration >= stopDurationThreshold) {
          stops.add(currentStopStart);
        }
        currentStopStart = null;
        stopDuration = 0;
      }
    }

    if (currentStopStart != null && stopDuration >= stopDurationThreshold) {
      stops.add(currentStopStart);
    }

    return stops;
  }

}

class Location {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  Location({required this.latitude, required this.longitude, required this.timestamp});
}