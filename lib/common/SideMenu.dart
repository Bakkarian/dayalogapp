import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/colors.dart';
class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  final mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: _mainController.themeChangeProvider.darkTheme?Colors.grey[900]:Colors.grey[100],
                borderRadius: BorderRadius.circular(16)
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                        Icons.sunny
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: _mainController.themeChangeProvider.darkTheme,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        // setState(() {
                          _mainController.themeChangeProvider.darkTheme = value;
                        // });
                      },
                    ),
                    Icon(
                      Icons.dark_mode
                    )
                  ],
                ),
              ),
            ),
          ),
          /*decoration: BoxDecoration(
            color: primaryColor,
          ),*/
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Wallet",
                  style: TextStyle(
                    color: Colors.grey[600],
                    // fontWeight: FontWeight.w700
                  ),
                ),
              ),*/
              ListTile(
                focusColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).focusColor,
                title: Row(
                  children: [
                    Icon(Icons.account_balance_wallet_rounded,
                      color: Colors.grey[600],),
                    SizedBox(width: 10,),
                    Text('View Wallet',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                        fontSize: 16
                      ),)
                  ],
                ),
                onTap: () async{
                  if(MediaQuery.of(context).size.width < 600){
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
