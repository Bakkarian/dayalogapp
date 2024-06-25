import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/QRcode/QRhome.dart';
import 'package:dayalog/pages/Trucks/AllTrucks.dart';
import 'package:dayalog/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  mainController _mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          _mainController.themeChangeProvider.darkTheme?"assets/images/logo-white.png":"assets/images/logo.png",
          width: 150,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Obx(()=>
                    dashTile(
                        "Trucks",
                        HeroIcons.truck,
                        green,
                        "${_mainController.devices.length}",
                        "enrolled",
                        "${_mainController.parkedDevices.value} parked",
                            (){Get.to(AllTrucks());}
                    )
                ),
                SizedBox(width: 20,),
                dashTile(
                  "Codes",
                  HeroIcons.qrCode,
                  accentColor,
                  "122",
                  "active",
                  "Truck seals",
                    (){Get.to(QRhome());}
                ),
                // dashTile(),
              ],
            )
          ],
        ),
      ),
    );
  }

  dashTile(title, icon, color, contentText, contentSuffix, bottomText, function){
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(14))
        ),
        child: InkWell(
          onTap: function,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "$title",
                      style: TextStyle(
                          color: white
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: HeroIcon(
                      icon,
                      style: HeroIconStyle.solid,
                      color: white,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "$contentText",
                    style: TextStyle(
                      color: white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "$contentSuffix",
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "$bottomText",
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: white,
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
