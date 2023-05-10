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
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 10,
          itemBuilder: (context,index){
          var tag = "home_tripItem-$index";
        return tripItem(detailedView: false,tag: tag,);
      }),
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
