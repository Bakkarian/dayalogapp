import 'dart:io';

import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  Loader({Key? key}) : super(key: key);
  mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Platform.isIOS?CupertinoActivityIndicator(animating: true,radius: 12,):
      CircularProgressIndicator(strokeWidth: 4,backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).indicatorColor,),
    );
  }
}
