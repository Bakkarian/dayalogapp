import 'dart:async';
import 'dart:math';

import 'package:dayalog/controllers/mainController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import '../../styles/styles.dart';

class ViewLocation extends StatefulWidget {
  var position;
  ViewLocation({Key? key, required this.position}) : super(key: key);

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
  addMarker()async{
    var markerIdVal = _mainController.getRandomString(10);
    final MarkerId markerId = MarkerId(markerIdVal);
    var showLocation = LatLng(widget.position["lat"], widget.position["lng"]);
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();

    setState(() {
      markers.add(Marker( //add first marker
        markerId: markerId,
        position: showLocation, //position of marker
        icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow( //popup info
          title: 'My Custom Title ',
          snippet: 'My Custom Subtitle',
        ),
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _positionToLoad = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(widget.position["lat"], widget.position["lng"]),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context).backgroundColor,
      appBar: AppBar(
        title: Text(
            "View Location"
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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialLocation,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
          controller.setMapStyle(_mapStyle);
          _goToLocation();
        },
        myLocationButtonEnabled: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToLocation,
        label: const Text('Go to location'),
        icon: const Icon(Icons.pin_drop_outlined),
      ),
    );
  }
}
