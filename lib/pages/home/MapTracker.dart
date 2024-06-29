import 'dart:collection';
import 'dart:convert';

import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/services/CRUD.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import '../../common/Loader.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

import '../../styles/styles.dart';

class MapTracker extends StatefulWidget {
  var deviceId, startDate, endDate;
  MapTracker({Key? key, required this.deviceId, this.startDate, this.endDate}) : super(key: key);

  @override
  State<MapTracker> createState() => _MapTrackerState();
}

class _MapTrackerState extends State<MapTracker> {

  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();
  var positions = [];
  var loading = true;
  var mapLoading = true;
  final List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = HashSet<Polyline>();
  late GoogleMapController mapController;
  late String _mapStyle;
  final mainController _mainController = Get.find();
  final Set<Marker> markers = new Set();
  List<Location> locations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPositions();
    rootBundle.loadString(_mainController.themeChangeProvider.darkTheme?'assets/map_style_dark.txt':'assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    // getCordinates();
  }
  /*getCordinates() async{
    var results = await dataManagement().getDeviceLocations(widget.deviceId, widget.startDate, widget.endDate);
    debugPrint("POSITIONS::: $results");
    setState(() {
      loading = false;
    });
  }*/
  fetchPositions() async{
    // var data = await mapService().getPositionsJson(context);
    var results = await dataManagement().getDeviceLocations(widget.deviceId, widget.startDate, widget.endDate);
    var data = jsonDecode(results);
    positions.addAll(data["data"]);
    debugPrint("POSITIONS:::: ${data["data"]}");
    positions.forEach((item) {
      locations.add(
        Location(latitude: double.parse(item["latitude"].toString()), longitude: double.parse(item["longitude"].toString()), timestamp: DateTime.parse(item["devicetime"].toString()))
      );
      polylineCoordinates.add(
          LatLng(double.parse(item["latitude"].toString()), double.parse(item["longitude"].toString()))
      );
    });

    debugPrint("LOCATIONS::: $locations");
    if (_mainController.enableStops) {
      // debugPrint("STOPS::: ${_mainController.detectStops(locations)}");
      var stops = await _mainController.detectStops(locations);
      stops.forEach((Location item){
        addMarker(item.latitude,item.longitude, item.timestamp);
      });
    }

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

  String imgurl = "assets/images/stop.png";
  addMarker(lat,lng, time)async{
    var markerIdVal = _mainController.getRandomString(10);
    final MarkerId markerId = MarkerId(markerIdVal);
    var showLocation = LatLng(lat, lng);

    ByteData bytesDats = await rootBundle.load(imgurl);
    Uint8List bytes = bytesDats.buffer.asUint8List();

    setState(() {
      markers.add(Marker( //add first marker
        markerId: markerId,
        position: showLocation, //position of marker
        icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow( //popup info
          title: 'Stop ',
          snippet: '$time',
        ),
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        onTap: (){
          // addInfoWindow(showLocation);
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).canvasColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Tracking"
            ),
            SizedBox(width: 10,),
            loading || mapLoading?SizedBox(
                width: 12,
                height: 12,
                child: Loader()
            ):SizedBox()
          ],
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
        apiKey: _mainController.apiKey,
        key: mapsWidgetController,
        // style: _mapStyle,
        onMapCreated: (GoogleMapController controller){
          mapController = controller;
          mapController.setMapStyle(_mapStyle);
          setState(() {
            mapLoading = false;
          });
        },
        sourceLatLng: LatLng(
          positions[0]["latitude"], positions[0]["longitude"],
        ),
        destinationLatLng: LatLng(
          positions[positions.length-1]["latitude"], positions[positions.length-1]["longitude"],
        ),

        sourceMarkerIconInfo: MarkerIconInfo(
          infoWindowTitle: "This is source name",
          onTapInfoWindow: (_) {
            print("Tapped on source info window");
          },
          assetPath: "assets/images/car.png",
        ),
        destinationMarkerIconInfo: MarkerIconInfo(
          assetPath: "assets/images/car.png",
        ),
        driverMarkerIconInfo: MarkerIconInfo(
          infoWindowTitle: "Alex",
          assetPath: "assets/images/car.png",
          onTapMarker: (currentLocation) {
            print("Driver is currently at $currentLocation");
          },
          // assetMarkerSize: Size.square(125),
          rotation: 0,
        ),
        routeWidth: 2,
        routeColor: _mainController.themeChangeProvider.darkTheme?Colors.blueAccent:Colors.blue[800]!,
        updatePolylinesOnDriverLocUpdate: false,
        onPolylineUpdate: (_) {
          print("Polyline updated");
        },
        zoomControlsEnabled: false,
        trafficEnabled: true,
        liteModeEnabled: false,
        markers: markers,
        // mock stream
        /*driverCoordinatesStream: Stream.periodic(
          Duration(milliseconds: 300),
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
