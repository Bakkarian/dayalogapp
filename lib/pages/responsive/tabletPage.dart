import 'package:dayalog/common/SideMenu.dart';
import 'package:dayalog/controllers/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/styles.dart';

class tabletPage extends StatelessWidget {

  final Widget page;

  tabletPage({required this.page});

  final mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).canvasColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              // height: 400,
              decoration: BoxDecoration(
                color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).cardColor,
              ),
              child: SideMenu(),
            ),
            Expanded(child: page)
          ],
        ),
      ),
    );
  }
}
