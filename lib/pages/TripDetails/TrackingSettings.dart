import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/home/MapTracker.dart';
import 'package:dayalog/styles/colors.dart';
import 'package:dayalog/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:get/get.dart';

class TrackingSettings extends StatefulWidget {
  var deviceId, deviceName;
  TrackingSettings({super.key, this.deviceId, this.deviceName});

  @override
  State<TrackingSettings> createState() => _TrackingSettingsState();
}

class _TrackingSettingsState extends State<TrackingSettings> {
  var _startDate,_endDate;
  mainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tracking Settings"
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Select the start date and the end date to fetch Data for ${widget.deviceName ?? ''}",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      TextButton(
                          style: primaryOutlineButtonStyle,
                          onPressed: () {
                            picker.DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(DateTime.now().year, 1, 1, 00, 00),
                              maxTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59),
                              onChanged: (date) {
                                print('change $date');
                              },
                              onConfirm: (date) {
                                print('confirm $date');
                                var formatedDate = date.toString().split(".").first;
                                setState(() {
                                  _startDate = formatedDate;
                                });
                              },
                              currentTime: DateTime.now(),
                              locale: picker.LocaleType.en,
                              theme: picker.DatePickerTheme(
                                  headerColor: veryVeryLightGrey,
                                  // backgroundColor: Colors.blue,
                                  /*itemStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),*/
                                  doneStyle: TextStyle(color: green, fontSize: 16),
                                  cancelStyle: TextStyle(
                                    color: Colors.orange,
                                  )
                              ),
                            );

                          },
                          child: Text(
                            'Start Date',
                            style: TextStyle(color: Colors.blue),
                          )),
                      Text(
                          "${_startDate ?? ''}",
                        style: TextStyle(
                          fontSize: 13
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: veryLightGrey,
                  ),
                  Column(
                    children: [
                      TextButton(
                          style: accentOutlineButtonStyle,
                          onPressed: () {
                            picker.DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(DateTime.now().year, 1, 1, 00, 00),
                              maxTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59),
                              onChanged: (date) {
                                print('change $date');
                              },
                              onConfirm: (date) {
                                print('confirm $date');
                                var formatedDate = date.toString().split(".").first;
                                setState(() {
                                  _endDate = formatedDate;
                                });
                              },
                              currentTime: DateTime.now(),
                              locale: picker.LocaleType.en,
                              theme: picker.DatePickerTheme(
                                  headerColor: veryVeryLightGrey,
                                  // backgroundColor: Colors.blue,
                                  /*itemStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),*/
                                  doneStyle: TextStyle(color: green, fontSize: 16),
                                  cancelStyle: TextStyle(
                                    color: Colors.orange,
                                  )
                              ),
                            );

                          },
                          child: Text(
                            'End Date',
                            style: TextStyle(color: Colors.blue),
                          )),
                      Text(
                        "${_endDate ?? ''}",
                        style: TextStyle(
                            fontSize: 13
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            // SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*Icon(
                      Icons.stop_screen_share_outlined
                  ),*/
                  Text(
                      "Show Stops"
                  ),
                  SizedBox(width: 5,),
                  Switch(
                    // This bool value toggles the switch.
                    value: _mainController.enableStops,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                      _mainController.enableStops = value;
                      });
                    },
                  ),
                  Icon(
                      Icons.location_on_rounded,
                    color: _mainController.enableStops?green:orange,
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                style: primaryButton,
                onPressed: _startDate!=null&&_endDate!=null?(){
                  Get.to(MapTracker(deviceId: widget.deviceId, startDate: _startDate, endDate: _endDate,));
                }:null,
                child: Text(
                    "Start Tracking"
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
