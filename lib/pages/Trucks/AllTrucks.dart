import 'dart:convert';

import 'package:dayalog/common/Loader.dart';
import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/TripDetails/TripDetails.dart';
import 'package:dayalog/pages/viewLocation/ViewLocation.dart';
import 'package:dayalog/services/CRUD.dart';
import 'package:dayalog/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class AllTrucks extends StatefulWidget {
  const AllTrucks({super.key});

  @override
  State<AllTrucks> createState() => _AllTrucksState();
}

class _AllTrucksState extends State<AllTrucks> {
  mainController _mainController = Get.find();
  var _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTrucks();
    // _mainController.getDevices();
  }
  /*getTrucks() async{
    var results = await dataManagement().getDevices();
    debugPrint("${jsonDecode(results)["data"][jsonDecode(results)["data"].length-1]} -- ${jsonDecode(results)["data"].length-1}");
    setState(() {
      _data = jsonDecode(results)["data"];
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Trucks"
        ),
      ),
      body: Obx(()=>
      _mainController.devices.length==0?
      Center(child: Loader()):
      ListView.builder(
          padding: EdgeInsets.all(14),
          itemCount: _mainController.devices.length,
          itemBuilder: ((context, index){
            var item = _mainController.devices[index];
            return Card(
              color: white,
              shadowColor: veryLightGrey.withOpacity(0.5),
              elevation: 2,
              child: InkWell(
                onTap: (){
                  var position = {
                    "lat": item["lastPosition"]["latitude"],
                    "lng": item["lastPosition"]["longitude"],
                  };
                  Get.to(ViewLocation(data: item, index: index,));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: item["status"]!="online"?grey.withOpacity(0.4):veryLightGrey,
                            borderRadius: BorderRadius.all(Radius.circular(25))
                        ),
                        child: HeroIcon(
                          HeroIcons.truck,
                          color: white,
                        ),
                      ),
                      SizedBox(width: 14,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      HeroIcon(
                                        HeroIcons.wifi,
                                        size: 13,
                                        style: HeroIconStyle.solid,
                                        color: item["status"]=="online"?green:orange,
                                      ),
                                      Text(
                                        "${item["status"]}",
                                        style: TextStyle(
                                            color: item["status"]=="online"?green:orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: item["motionstate"]==0?accentColor.withOpacity(0.2):green.withOpacity(0.6),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Text(
                                    "${item["motionstate"]==0?"Parked":"Moving"}",
                                    style: TextStyle(
                                        color: black.withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Text("${(jsonDecode(item["lastPosition"]["attributes"])["totalDistance"]/1000).toStringAsFixed(2)} Km"),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
      )
      ),
    );
  }
}
