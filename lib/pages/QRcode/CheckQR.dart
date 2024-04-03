import 'dart:io';

import 'package:dayalog/services/CRUD.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../controllers/mainController.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class CheckQR extends StatefulWidget {
  const CheckQR({super.key});

  @override
  State<CheckQR> createState() => _CheckQRState();
}

class _CheckQRState extends State<CheckQR> with TickerProviderStateMixin{
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  TextEditingController sealNoController = TextEditingController();
  final mainController _mainController = Get.find();
  var _serial;
  var _loading = false;
  var _done = false;
  var _verified = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

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
                  _done&&!_verified?SizedBox(
                    width: 50,
                      child: Lottie.asset(
                          "assets/images/done_animation.json",
                        controller: _controller,
                        onLoaded: (composition) {
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                  ):SizedBox(),
                  _verified?Lottie.asset(
                      "assets/images/error_animation.json",
                    width: 80,
                    controller: _controller,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    },
                  ):SizedBox(),
                  Center(
                    child:Text(
                        '${/*describeEnum(result!.format)*/""}Code: ${result!.code}'),
                  ),
                  _serial!=null?Center(
                    child:Text(
                        'Serial: ${_serial}'),
                  ):SizedBox(),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 45,
                    width: 170,
                    child: TextButton(
                      onPressed: _loading?null:() async{
                        setState(() {
                          _loading = true;
                          _done = false;
                          _verified = false;
                        });
                        var response = await dataManagement().checkQR(result!.code);
                        print(response);
                        setState(() {
                          _loading = false;
                        });
                        if(response!=null){
                          setState(() {
                            _done = true;
                            _verified = response["verified"];
                            _serial = response["verified"]?"Already Scanned and VERIFIED!":response["serial"];
                          });
                        }
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
                          "${_loading?'Loading...':'Check Code'}"
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
    _controller.dispose();
    super.dispose();
  }
}
