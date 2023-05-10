import 'dart:async';

import 'package:dayalog/pages/MainPage.dart';
import 'package:dayalog/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mainController.dart';

class Launcher extends StatefulWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {

  final mainController _mainController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () => Get.to(const MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
      body: Center(
        child: Image.asset(
          _mainController.themeChangeProvider.darkTheme?"assets/images/logo-white.png":"assets/images/logo.png",
          width: 200,
        ),
      ),
    );
  }
}
