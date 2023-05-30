import 'dart:ffi';

import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/TripDetails/TripDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home/MapTracker.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

class tripItem extends StatefulWidget {
  bool detailedView;
  String? tag,delivery;
   tripItem({required this.detailedView, this.tag, this.delivery});

  @override
  State<tripItem> createState() => _tripItemState(detailedView: detailedView,);
}

class _tripItemState extends State<tripItem> {
  bool detailedView;
  _tripItemState({required this.detailedView});
  
  final mainController _mainController = Get.find();
  
  
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag!=null?"${widget.tag}":"",
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 20),
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
        child: InkWell(
          onTap: detailedView?null:(){
            Get.to(TripDetails());
          },
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
                                    "Pickup Point - ${widget.delivery}",
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

              SizedBox(height: 10,),
              detailedView?Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
                  borderRadius: BorderRadius.circular(10)
                ),
              ):SizedBox(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
