import 'dart:io';

import 'package:dayalog/common/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/tripItem.dart';
import '../../controllers/mainController.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class mobileHomePage extends StatefulWidget {
  const mobileHomePage({Key? key}) : super(key: key);

  @override
  State<mobileHomePage> createState() => _mobileHomePageState();
}

class _mobileHomePageState extends State<mobileHomePage> {

  final mainController _mainController = Get.find();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.grey[500],
          ),
          onPressed: () {
            // Scaffold.of(context).openDrawer();
            _key.currentState!.openDrawer();
          },
        ),
        title: Image.asset(
          _mainController.themeChangeProvider.darkTheme?"assets/images/logo-white.png":"assets/images/logo.png",
          width: 150,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(24),
                  // border: Border.all(color: Colors.green[200]!)
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      child: Icon(
                        Icons.backpack_outlined,
                        color: grey.withOpacity(0.2),
                        size: 180,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Track your shipment",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Track your most recent \nshipments here",
                            style: TextStyle(
                                fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: TextButton(
                              onPressed: (){
                                Get.to(MapTracker());
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                  ),
                                  disabledBackgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).primaryColor.withOpacity(0.7),
                                  disabledForegroundColor: Colors.white.withOpacity(0.5),
                                  backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, Get.context!).primaryColor,
                                  foregroundColor: Colors.black,
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              child: Text(
                                  "Track"
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            ListView.builder(
              itemCount: 10,
                padding: EdgeInsets.all(20),
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context,index){
                var tag = "home_tripItem-$index";
              return tripItem(detailedView: false,tag: tag,);
            }),*/
            SizedBox(height: 100,),
            Center(
              child: Text(
                "You have no Orders",
                style: TextStyle(
                  color: grey.withOpacity(0.5),
                  fontWeight: FontWeight.w900,
                  fontSize: 32
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 45,
              width: 150,
              child: TextButton(
                onPressed: () async{
                  /*final Uri _url = Uri.parse('https://patasente.page.link/create_order');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }*/
                  final Uri _url = Uri.parse('pat://patasente.me/create_order');
                  try {
                    if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Patasente not installed")));
                    print("Patasente not installed");
                    if (Platform.isAndroid || Platform.isIOS) {
                      final appId = Platform.isAndroid ? 'com.patasente.e' : '1553761945';
                      final url = Uri.parse(
                        Platform.isAndroid
                            ? "market://details?id=$appId"
                            : "https://apps.apple.com/app/id$appId",
                      );
                      launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  }
                  /*const url = 'pat://patasente.me';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Patasente not installed")));
                  }*/
              },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    disabledBackgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).buttonColor.withOpacity(0.7),
                    disabledForegroundColor: Colors.white.withOpacity(0.5),
                    backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, Get.context!).buttonColor,
                    foregroundColor: white,
                    textStyle: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold
                    )
                ),
                child: Text(
                    "Create New Order"
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).cardColor,
        child: SideMenu(),
      ),
    );
  }
}
