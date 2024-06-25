import 'dart:async';
import 'dart:math';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/TripDetails/TrackingSettings.dart';
import 'package:dayalog/pages/home/MapTracker.dart';
import 'package:dayalog/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:heroicons/heroicons.dart';

import '../../styles/colors.dart';
import '../../styles/styles.dart';

class ViewLocation extends StatefulWidget {
  var data;
  var index;
  ViewLocation({Key? key, this.data, this.index}) : super(key: key);

  @override
  State<ViewLocation> createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {

  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();
  var positions = [];
  var loading = true;
  late String _mapStyle;
  final mainController _mainController = Get.find();

  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  List<LatLng> routeCoordinates = [];

  static const CameraPosition _initialLocation = CameraPosition(
    target: LatLng(0.3502223710191752, 32.59810888252596),
    zoom: 14.4746,
  );

  static CameraPosition? _positionToLoad;

  Future<void> _goToLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_positionToLoad!));
    addMarker();
  }


  final Set<Marker> markers = new Set();

  // creating a new MARKER
  String imgurl = "assets/images/car.png";
  String imgurl2 = "assets/images/dot.png";
  addMarker()async{
    var markerIdVal = _mainController.getRandomString(10);
    final MarkerId markerId = MarkerId(markerIdVal);
    var showLocation = LatLng(_mainController.devices[widget.index]["lastPosition"]["latitude"] ?? 0.0, _mainController.devices[widget.index]["lastPosition"]["longitude"] ?? 0.0);

    ByteData bytesDats = await rootBundle.load(imgurl);
    Uint8List bytes = bytesDats.buffer.asUint8List();

    setState(() {
      markers.add(Marker( //add first marker
        markerId: markerId,
        position: showLocation, //position of marker
        icon: BitmapDescriptor.fromBytes(bytes),
        /*infoWindow: InfoWindow( //popup info
          title: 'My Custom Title ',
          snippet: 'My Custom Subtitle',
        ),*/
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        onTap: (){
          addInfoWindow(showLocation);
        },
      ));
    });
    updateMarker(markerId);
  }

  addInfoWindow(showLocation){
    _customInfoWindowController.addInfoWindow!(
      Container(
        color: white,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(4),
                ),
                width: double.infinity,
                // height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: _mainController.devices[widget.index]["status"]=="online"?Colors.lightGreen:orange
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_mainController.devices[widget.index]["name"]}",
                            style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                          ),
                          Row(
                            children: [
                              HeroIcon(
                                HeroIcons.wifi,
                                size: 13,
                                style: HeroIconStyle.solid,
                                color: _mainController.devices[widget.index]["status"]=="online"?green:orange,
                              ),
                              Text(
                                "${_mainController.devices[widget.index]["status"]}",
                                style: TextStyle(
                                    color: _mainController.devices[widget.index]["status"]=="online"?green:orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: (){
                      Get.to(MapTracker(deviceId: _mainController.devices[widget.index]["id"],));
                    },
                    child: const Text('Details'),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    style: accentOutlineButtonStyle,
                    onPressed: (){
                      print("ID:: ${_mainController.devices[widget.index]["id"]}");
                      Get.to(
                          TrackingSettings(
                            deviceId: _mainController.devices[widget.index]["id"],
                            deviceName: _mainController.devices[widget.index]["name"],
                          )
                      );
                    },
                    child: const Text('Track'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      showLocation,
    );
  }

  late Timer _timer;
  updateMarker(MarkerId markerId) async{
    var _mapController = _customInfoWindowController.googleMapController;


    var _currentPosition = LatLng(_mainController.devices[widget.index]["lastPosition"]["latitude"],_mainController.devices[widget.index]["lastPosition"]["longitude"]);
    // final MarkerId markerId = MarkerId('current_marker');

    // Remove the old marker
    setState(() {
      markers.removeWhere((marker) => marker.markerId == markerId);
    });

    // Add the new marker with the updated position
    ByteData bytesDats = await rootBundle.load(imgurl);
    Uint8List bytes = bytesDats.buffer.asUint8List();
    //dot Image
    ByteData bytesData = await rootBundle.load(imgurl2);
    Uint8List bytes2 = bytesData.buffer.asUint8List();
    // _addMarker(_currentPosition);
    /*markers.add(Marker( //add first marker
      markerId: MarkerId(_mainController.getRandomString(10)),
      position: _currentPosition, //position of marker
      icon: BitmapDescriptor.fromBytes(bytes2),
      onTap: (){
        // addInfoWindow(_currentPosition);
      },
    ));*/
    markers.add(Marker( //add first marker
      markerId: markerId,
      position: _currentPosition, //position of marker
      icon: BitmapDescriptor.fromBytes(bytes),
      onTap: (){
        addInfoWindow(_currentPosition);
      },
    ));

    setState(() {
      _timer = new Timer.periodic(const Duration(seconds: 5), (timer){
        updateMarker(markerId);
        _timer.cancel();
      });

      routeCoordinates.add(_currentPosition);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _positionToLoad = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(_mainController.devices[widget.index]["lastPosition"]["latitude"] ?? 0.0, _mainController.devices[widget.index]["lastPosition"]["longitude"] ?? 0.0),
          // tilt: 59.440717697143555,
          zoom: 15.0,
      );
    });

    rootBundle.loadString(_mainController.themeChangeProvider.darkTheme?'assets/map_style_dark.txt':'assets/map_style.txt').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).canvasColor,
      appBar: AppBar(
        title: Text(
            "Location: ${_mainController.devices[widget.index]["name"]}"
        ),
        /*leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[500],
          ),
          onPressed: () {
            Get.back();
          },
        ),*/
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialLocation,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              controller.setMapStyle(_mapStyle);
              _customInfoWindowController.googleMapController = controller;
              _goToLocation();
            },
            myLocationButtonEnabled: false,
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                points: routeCoordinates, // List<LatLng> of your route's coordinates
                color: primaryColor,
                width: 3,
                zIndex: 1000
              ),
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 250,
            offset: 50,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToLocation,
        label: const Text('Go to location'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}
