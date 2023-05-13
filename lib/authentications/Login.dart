import 'package:dayalog/common/Loader.dart';
import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/Launcher/Launcher.dart';
import 'package:dayalog/styles/colors.dart';
import 'package:dayalog/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../services/CRUD.dart';
import '../styles/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var _hidePassword = true;
  final mainController _mainController = Get.find();
  var _msg;
  var _isLoading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 150,),
                const Text(
                  "Log into your account",
                  style: TextStyle(
                      // color: black,
                      fontWeight: FontWeight.w900,
                      fontSize: 26
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "Login with your Patasente Account",
                  style: TextStyle(
                    color: grey,
                  ),
                ),
                SizedBox(height: 50,),
                CupertinoTextField(
                  placeholder: "Email / Phone / Merchant Code",
                  controller: usernameController,
                  placeholderStyle: TextStyle(
                      color: _mainController.themeChangeProvider.darkTheme?Colors.grey[600]:Colors.grey[400]
                  ),
                  style: TextStyle(
                    color: _mainController.themeChangeProvider.darkTheme?Colors.grey[200]:Colors.black
                  ),
                  suffix: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.person,color: _mainController.themeChangeProvider.darkTheme?Colors.grey[600]:Colors.grey,),
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
                SizedBox(height: 10.0,),
                CupertinoTextField(
                  placeholder: "Password",
                  controller: passwordController,
                  placeholderStyle: TextStyle(
                      color: _mainController.themeChangeProvider.darkTheme?Colors.grey[600]:Colors.grey[400]
                  ),
                  style: TextStyle(
                      color: _mainController.themeChangeProvider.darkTheme?Colors.grey[200]:Colors.black
                  ),
                  suffix: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      icon: Icon(Icons.remove_red_eye,color: _mainController.themeChangeProvider.darkTheme?Colors.grey[600]:Colors.grey,),
                      onPressed: (){
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _hidePassword,
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
                SizedBox(height: 10,),

                _isLoading?Loader():SizedBox(),

                _msg!=null?Center(
                  child: Text(
                    _msg,
                    textAlign: TextAlign.center,
                  ),
                ):SizedBox(),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: usernameController.text!=""&&passwordController.text!=""&&!_isLoading?(){
                      _login();
                    }:null,
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
                        "Login"
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: (){

                    },
                    style: OutlinedButton.styleFrom(
                      // primary: Colors.black87,
                      primary: _mainController.themeChangeProvider.darkTheme?white:accentColor,
                      // minimumSize: Size(88, 36),
                      // padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ).copyWith(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return BorderSide(
                              color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, Get.context!).buttonColor,
                              width: 1,
                            );
                          }else{
                            return BorderSide(
                              color: _mainController.themeChangeProvider.darkTheme?const Color(0xff3B3B3B):accentColor,
                              width: 1,
                            );
                          }
                        },
                      ),
                    ),
                    child: Text(
                        "Create Account"
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() async{
    setState(() {
      _isLoading = true;
      _msg = null;
    });
    _mainController.hideKeyboard(context);
    userManagement().login(usernameController.text, passwordController.text).then((response)async{
      // print(response);
      var data = convert.jsonDecode(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(data["error"]!=null){
        // //print(data["error"]);
        setState(() {
          _msg = data["error"];
          _isLoading = false;
        });
      }else{
        if(data["token"]!=null){
          /*prefs.setString("token", data["token"]);
        prefs.setBool("isLoggedIn", true);*/
          var userDetails = await userManagement().getUserDetails(data["token"]);
          var user = {
            "userDetails": convert.jsonDecode(userDetails),
            "token": "${data["token"]}",
            "isLoggedIn": true,
          };

          prefs.setString("user", convert.jsonEncode(user));
          _mainController.userString.value = prefs.getString("user")!;
          // print(_mainController.userString.value);
          setState(() {
            _isLoading = false;
          });
          // dataManagement().saveNotificationToken();
          Get.offAll(const Launcher());
        }
      }
    });
  }
}
