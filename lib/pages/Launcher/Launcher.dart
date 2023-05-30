import 'dart:async';

import 'package:dayalog/pages/MainPage.dart';
import 'package:dayalog/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentications/Login.dart';
import '../../controllers/mainController.dart';
import 'dart:convert' as convert;

import '../../services/CRUD.dart';

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
    // Timer(const Duration(seconds: 2), () => Get.offAll(const Login()));
    checkIfLoggedIn();
  }
  checkIfLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("user");
    // print(userData);
      if(
        userData!=null &&
        convert.jsonDecode(userData)["isLoggedIn"] !=null &&
        convert.jsonDecode(userData)["isLoggedIn"] == true
      ){
        var token = convert.jsonDecode(userData)["token"];
        // print(token);
        var userDetails = await userManagement().getUserDetails(token);
        var user = {
          "userDetails": convert.jsonDecode(userDetails),
          "token": "$token",
          "isLoggedIn": true,
        };

        prefs.setString("user", convert.jsonEncode(user));
        setState(() {
          _mainController.userString.value = prefs.getString("user")!;
        });
        // Get.offAll(const MainPage());
        _mainController.initUniLinks();
    }else{
      Get.offAll(const Login());
    }
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
