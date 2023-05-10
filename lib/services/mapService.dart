
import 'dart:convert';

import 'package:flutter/material.dart';

class mapService{
  var positions = [];
  getPositionsJson(context) async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/images/positions.json");
    var JSONdata = [];
    jsonDecode(data).forEach((element) {
      JSONdata.add(element);
    });
    positions = JSONdata;
    return positions; //latest Dart
  }

  getNumberOfOrders(){
    return positions.length;
  }
}