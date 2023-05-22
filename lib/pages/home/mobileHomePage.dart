import 'package:dayalog/common/SideMenu.dart';
import 'package:dayalog/pages/home/MapTracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
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
            SizedBox(height: 40,),
            ListView.builder(
              itemCount: 10,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context,index){
                var tag = "home_tripItem-$index";
              return tripItem(detailedView: false,tag: tag,);
            }),
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
