import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/home/MapTracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/styles.dart';

class desktopPage extends StatelessWidget {

  final Widget page;

  desktopPage({required this.page});

  final mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).canvasColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 260,
            // height: 400,
            decoration: BoxDecoration(
              color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).cardColor,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).shadowColor,
                  child: MapTracker(),
                ),
                Container(
                  width: 400,
                  child: page,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
