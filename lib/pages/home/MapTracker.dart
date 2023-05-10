import 'dart:collection';

import 'package:dayalog/controllers/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import '../../common/Loader.dart';
import '../../services/mapService.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../styles/styles.dart';

class MapTracker extends StatefulWidget {
  const MapTracker({Key? key}) : super(key: key);

  @override
  State<MapTracker> createState() => _MapTrackerState();
}

class _MapTrackerState extends State<MapTracker> {

  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();
  var positions = [];
  var loading = true;
  final List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = HashSet<Polyline>();
  late GoogleMapController mapController;
  late String _mapStyle;
  final mainController _mainController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPositions();
    rootBundle.loadString(_mainController.themeChangeProvider.darkTheme?'assets/map_style_dark.txt':'assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  fetchPositions() async{
    var data = await mapService().getPositionsJson(context);
    positions.addAll(data);
    print(positions.length);
    positions.forEach((item) {
      polylineCoordinates.add(
          LatLng(item["latitude"], item["longitude"])
      );
    });

    _polylines.add(
      Polyline(
        polylineId: PolylineId('polyline'),
        color: _mainController.themeChangeProvider.darkTheme?Colors.white:Colors.red,
        width: 2,
        // jointType: JointType.round,
        points: polylineCoordinates,
      ),
    );
    setState(() {
      loading = false;
    });
    // print("POSITIONSZ:: $positions");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "Tracking"
        ),

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[500],
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: loading?SizedBox():
      GoogleMapsWidget(
        apiKey: "AIzaSyDcWnFHx3aRBy_3oEeDMydOLGECc0MNYjk",
        key: mapsWidgetController,
        onMapCreated: (GoogleMapController controller){
          mapController = controller;
          mapController.setMapStyle(_mapStyle);
        },
        sourceLatLng: LatLng(
          positions[0]["latitude"], positions[0]["longitude"],
      ),
        destinationLatLng: LatLng(
          positions[positions.length-1]["latitude"], positions[positions.length-1]["longitude"],
        ),

        /*sourceMarkerIconInfo: MarkerIconInfo(
          infoWindowTitle: "This is source name",
          onTapInfoWindow: (_) {
            print("Tapped on source info window");
          },
          assetPath: "assets/images/house-marker-icon.png",
        ),
        destinationMarkerIconInfo: MarkerIconInfo(
          assetPath: "assets/images/restaurant-marker-icon.png",
        ),*/
        driverMarkerIconInfo: MarkerIconInfo(
          infoWindowTitle: "Alex",
          assetPath: "assets/images/truck_marker.png",
          onTapMarker: (currentLocation) {
            print("Driver is currently at $currentLocation");
          },
          // assetMarkerSize: Size.square(125),
          rotation: 0,
        ),
        routeWidth: 2,
        routeColor: _mainController.themeChangeProvider.darkTheme?Colors.blueAccent:Colors.blue[800]!,
        updatePolylinesOnDriverLocUpdate: true,
        onPolylineUpdate: (_) {
          print("Polyline updated");
        },
        zoomControlsEnabled: false,
        trafficEnabled: false,
        liteModeEnabled: false,
        // mock stream
        /*driverCoordinatesStream: Stream.periodic(
          Duration(milliseconds: 500),
              (i) => LatLng(
            positions[i]["latitude"],
            positions[i]["longitude"],
          ),
        ),*/
        totalTimeCallback: (time) => print(time),
        totalDistanceCallback: (distance) => print(distance),
        polylines: _polylines,
      ),
    );
  }
}
