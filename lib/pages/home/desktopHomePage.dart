import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mainController.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class desktopHomePage extends StatefulWidget {
  const desktopHomePage({Key? key}) : super(key: key);

  @override
  State<desktopHomePage> createState() => _desktopHomePageState();
}

class _desktopHomePageState extends State<desktopHomePage> {

  final mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).canvasColor,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset(
          _mainController.themeChangeProvider.darkTheme?"assets/images/logo-white.png":"assets/images/logo.png",
          width: 150,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).shadowColor,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ]
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle_outlined,color: accentColor,),
                          Container(
                            width: 4,
                            height: 40,
                            color: _mainController.themeChangeProvider.darkTheme?Colors.grey[800]:Colors.grey[200],
                          ),
                          Icon(Icons.pin_drop_rounded,color: green,),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pickup Point",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400]
                                        ),

                                      ),
                                      Text(
                                          "Mbarara 4BD, New Rise Street"
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "7:15 am",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500]
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 26,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dropoff Point",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400]
                                        ),

                                      ),
                                      Text(
                                          "Kampala, nakasero 45 B"
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "EAT: 7:15 pm",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500]
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      )

                    ],
                  ),

                  //Divider
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey[400],),
                  SizedBox(height: 10,),

                  //Driver Details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).canvasColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ivan Driver",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                  decoration: BoxDecoration(
                                      color: green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Text(
                                    "on Trip",
                                    style: TextStyle(
                                      color: green,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "UBG 699U",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400]
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
