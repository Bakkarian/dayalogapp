import 'package:dayalog/pages/QRcode/CheckQR.dart';
import 'package:dayalog/pages/QRcode/ConfigureQR.dart';
import 'package:dayalog/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mainController.dart';
import '../../styles/styles.dart';

class QRhome extends StatefulWidget {
  const QRhome({super.key});

  @override
  State<QRhome> createState() => _QRhomeState();
}

class _QRhomeState extends State<QRhome> {
  final mainController _mainController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _mainController.setCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          _mainController.themeChangeProvider.darkTheme?"assets/images/logo-white.png":"assets/images/logo.png",
          width: 150,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Configure or scan QR codes for Dayalog",
                style: TextStyle(
                  color: _mainController.themeChangeProvider.darkTheme?white:grey
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: 200,
                child: TextButton(
                  onPressed: () async{
                    Get.to(ConfigureQR());
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      disabledBackgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).primaryColor.withOpacity(0.7),
                      disabledForegroundColor: Colors.white.withOpacity(0.5),
                      backgroundColor: green,
                      foregroundColor: white,
                      textStyle: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  child: Text(
                      "Configure Code"
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 45,
                width: 170,
                child: TextButton(
                  onPressed: () async{
                    Get.to(CheckQR());
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      disabledBackgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).primaryColor.withOpacity(0.7),
                      disabledForegroundColor: Colors.white.withOpacity(0.5),
                      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, Get.context!).primaryColor,
                      foregroundColor: white,
                      textStyle: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  child: Text(
                      "Scan Code"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
