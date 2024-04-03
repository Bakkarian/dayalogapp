import 'dart:ffi';

import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/TripDetails/TripDetails.dart';
import 'package:dayalog/pages/home/MapTracker.dart';
import 'package:dayalog/pages/viewLocation/ViewLocation.dart';
import 'package:dayalog/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';
import '../../../styles/styles.dart';

class tripDetailedItem extends StatefulWidget {
  bool detailedView;
   tripDetailedItem({required this.detailedView});

  @override
  State<tripDetailedItem> createState() => _tripDetailedItemState(detailedView: detailedView,);
}

class _tripDetailedItemState extends State<tripDetailedItem> with TickerProviderStateMixin {
  bool detailedView;
  _tripDetailedItemState({required this.detailedView});
  
  final mainController _mainController = Get.find();

  late Animation<double> animation;
  late AnimationController animationController;
  var animationLoaded = false;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animation = Tween<double>(begin: 0, end: 450).animate(animationController)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // animationController.reverse();
          setState(() {
            animationLoaded = true;
          });
        } else if (status == AnimationStatus.dismissed) {
          // animationController.forward();
        }
      });
    animationController.forward();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(20),
      // margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).cardColor,
          borderRadius: BorderRadius.circular(0),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
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
          ),

          SizedBox(height: 10,),
          detailedView?Container(
            height: animation.value,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
              // borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(20),
            child: AnimatedOpacity(
              opacity: animationLoaded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: 3,
                            height: 60,
                            color: _mainController.themeChangeProvider.darkTheme?Colors.grey[800]:Colors.grey[400],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.circle,
                              color: white,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5,),
                            Text(
                              "Pickup Point.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400]
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Isongiro",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  "8:30am",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.grey[600]
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  //if stop
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 3,
                            height: 50,
                            color: _mainController.themeChangeProvider.darkTheme?Colors.grey[800]:Colors.grey[400],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.circle,
                              color: veryLightGrey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Stop 1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "Mbarara town",
                                ),
                                Expanded(
                                  child: Text(
                                    "12:30pm",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.grey[600]
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "0.323454, 13.5674",
                              style: TextStyle(
                                color: CupertinoColors.activeBlue
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 3,
                            height: 50,
                            color: _mainController.themeChangeProvider.darkTheme?Colors.grey[800]:Colors.grey[400],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.circle,
                              color: veryLightGrey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Stop 2",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "Masaka town",
                                ),
                                Expanded(
                                  child: Text(
                                    "12:30pm",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.grey[600]
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "0.323454, 13.5674",
                              style: TextStyle(
                                color: CupertinoColors.activeBlue
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  // current driver location
                  Container(
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 3,
                              height: 100,
                              color: _mainController.themeChangeProvider.darkTheme?Colors.grey[800]:Colors.grey[400],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Current:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Mpigi town",
                                  ),
                                  Expanded(
                                    child: Text(
                                      "now",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  var location = {
                                    "lat": 0.359010,
                                    "lng": 32.598120
                                  };
                                  Get.to(ViewLocation(position: location,));
                                },
                                child: Text(
                                  "0.359010, 32.598120",
                                  style: TextStyle(
                                    color: CupertinoColors.activeBlue
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //destination
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 3,
                            height: 60,
                            color: _mainController.themeChangeProvider.darkTheme?Colors.grey[800]:Colors.grey[400],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.pin_drop,
                              color: white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              "Final Delivery Point.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400]
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Kampala, Kikuubo, Kikuubo road",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  ".",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.grey[600]
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
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
                          foregroundColor: white,
                          textStyle: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      child: Text(
                        "View on Map"
                      ),
                    ),
                  )

                ],
              ),
            ),
          ):SizedBox(),
          //Divider
          // SizedBox(height: 10,),
          // Divider(color: Colors.grey[400],),
          SizedBox(height: 20,),

          //Driver Details
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
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
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "UBG 699U",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500]
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
