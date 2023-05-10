import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/TripDetails/widgets/tripDetailedItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/tripItem.dart';
import '../../styles/styles.dart';

class TripDetails extends StatefulWidget {
  TripDetails({Key? key}) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {

  mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[500],
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Trip Details"
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tripDetailedItem(detailedView: true)
          ],
        ),
      ),
    );
  }
}
