import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayalog/services/CRUD.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../controllers/mainController.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class ConfigureQR extends StatefulWidget {
  const ConfigureQR({super.key});

  @override
  State<ConfigureQR> createState() => _ConfigureQRState();
}

class _ConfigureQRState extends State<ConfigureQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  TextEditingController sealNoController = TextEditingController();
  final mainController _mainController = Get.find();
  var _loading = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 2,
            child: (result != null)?
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child:Text(
                        '${/*describeEnum(result!.format)*/""}Code: ${result!.code}'),
                  ),
                  SizedBox(height: 20,),
                  CupertinoTextField(
                    placeholder: "Seal Number",
                    controller: sealNoController,
                    textCapitalization: TextCapitalization.characters,
                    placeholderStyle: TextStyle(
                        color: _mainController.themeChangeProvider.darkTheme?Colors.grey[600]:Colors.grey[400]
                    ),
                    style: TextStyle(
                        color: _mainController.themeChangeProvider.darkTheme?Colors.grey[200]:Colors.black
                    ),
                    suffix: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.sticky_note_2,color: _mainController.themeChangeProvider.darkTheme?Colors.grey[600]:Colors.grey,),
                    ),
                    decoration: BoxDecoration(
                      color: _mainController.themeChangeProvider.darkTheme?Colors.grey[900]:white,
                      border: Border.all(width: 1,style: BorderStyle.solid,color: _mainController.themeChangeProvider.darkTheme?Colors.grey[900]!:veryLightGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(15.0),
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      setState(() {

                      });
                    },
                  ),
                  Text(
                    "Add the number found on the seal in it's entirety",
                    style: TextStyle(
                      color: grey,
                      fontSize: 13
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 45,
                    width: 200,
                    child: TextButton(
                      onPressed: _loading?null: () async{
                        setState(() {
                          _loading = true;
                        });
                        if(sealNoController.text.isNotEmpty){
                          if (result!=null) {
                            dataManagement().configureQR("${result!.code}", "${sealNoController.text}").then((doc){
                              if(doc!=null) {
                                Get.back();
                                Get.snackbar("Success!", "Seal Number is added", backgroundColor: green, colorText: white, snackPosition: SnackPosition.BOTTOM);
                                setState(() {
                                  _loading = false;
                                });
                              }else{
                                Get.snackbar("Error!", "Code already exists!", backgroundColor: orange, colorText: black, snackPosition: SnackPosition.BOTTOM);
                              }
                            });
                          }
                        }else{
                          Get.snackbar("Error!", "Seal Number is required",  backgroundColor: red, colorText: white);
                        }
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
                          _loading?"Loading...":"Configure Code"
                      ),
                    ),
                  ),
                ],
              ),
            ):
                Center(
                  child: Text('Scan a code'),
                ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
