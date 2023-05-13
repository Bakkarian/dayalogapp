import 'package:dayalog/authentications/Login.dart';
import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../styles/colors.dart';
class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  final mainController _mainController = Get.find();
  var _userName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  _getUser() async{
    var userData = convert.jsonDecode(_mainController.userString.value);
    // print(userData);
    setState(() {
      _userName = userData["userDetails"]["business_name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hi $_userName",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  // height: 50,
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
              ],
            ),
          ),
          /*decoration: BoxDecoration(
            color: primaryColor,
          ),*/
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                    Text('Login Page',
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
                    Get.to(Login());
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
