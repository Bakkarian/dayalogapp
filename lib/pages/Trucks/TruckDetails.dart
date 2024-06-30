import 'dart:convert';

import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styles/styles.dart';

class TruckDetails extends StatefulWidget {
  var data;
  TruckDetails({super.key, required this.data});

  @override
  State<TruckDetails> createState() => _TruckDetailsState();
}

class _TruckDetailsState extends State<TruckDetails> {
  mainController _mainController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("${widget.data["attributes"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      /*appBar: AppBar(
        title: Text(
          "Truck Details"
        ),
      ),*/
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: green,
            ),
            child: Center(
              child: Text(
                  "${widget.data["name"]}",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[50],
                padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top: 200),
                child: Column(
                  children: [
                    Card(
                      color: white,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      HeroIcon(
                                        HeroIcons.bellAlert,
                                        color: jsonDecode(widget.data["lastPosition"]["attributes"])["alarm"]=="powerCut"?
                                        red:accentColor,
                                        style: HeroIconStyle.solid,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "${jsonDecode(widget.data["lastPosition"]["attributes"])["alarm"] ?? 'None'}",
                                        style: TextStyle(
                                          color: jsonDecode(widget.data["lastPosition"]["attributes"])["alarm"]=="powerCut"?
                                              red:accentColor
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      HeroIcon(
                                        HeroIcons.power,
                                        style: HeroIconStyle.solid,
                                        color: jsonDecode(widget.data["lastPosition"]["attributes"])["ignition"]?green:Colors.orange,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "${jsonDecode(widget.data["lastPosition"]["attributes"])["ignition"]?'Engine On':'Engine Off'}",
                                        style: TextStyle(
                                          color: jsonDecode(widget.data["lastPosition"]["attributes"])["ignition"]?green:orange
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            customDivider(width: double.infinity, height: 2.0,),
                            SizedBox(height: 14,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Course",
                                      style: TextStyle(
                                        color: grey,
                                        fontSize: 14
                                      ),
                                    ),
                                    RotationTransition(
                                      turns: AlwaysStoppedAnimation(widget.data["lastPosition"]["course"] / 360),
                                      child: HeroIcon(
                                        HeroIcons.arrowUp,
                                        style: HeroIconStyle.solid,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: 2,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      color: veryLightGrey
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Status",
                                      style: TextStyle(
                                        color: grey,
                                        fontSize: 14
                                      ),
                                    ),
                                    Text(
                                      "${widget.data["status"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: 2,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      color: veryLightGrey
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Motion",
                                      style: TextStyle(
                                        color: grey,
                                        fontSize: 14
                                      ),
                                    ),
                                    Text(
                                      "${jsonDecode(widget.data["lastPosition"]["attributes"])["motion"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 14,),
                            Center(
                              child: Text(
                                  "Total Distance: ${_mainController.formatNumber((jsonDecode(widget.data["lastPosition"]["attributes"])["totalDistance"]/1000).toStringAsFixed(0))} Km"
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async{
                          Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=${widget.data["lastPosition"]["latitude"]},${widget.data["lastPosition"]["longitude"]}');
                          if (!await launchUrl(googleUrl)) {
                            throw Exception('Could not launch $googleUrl');
                          }
                        },
                        child: Text("View on Google Maps")
                    ),
                    // Text("${widget.data.toString().split(",").join("\n")}"),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: HeroIcon(
                  HeroIcons.xMark
                ),
                onPressed: (){
                  Get.back();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class customDivider extends StatelessWidget {
  var width, height;
  customDivider({
    super.key,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.9, 0.0),
            radius: 120,
            colors: <Color>[
              Colors.transparent,
              veryLightGrey,
            ],
          )
      ),
    );
  }
}
