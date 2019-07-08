import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;


class MapUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter MapUi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(37.4219999, -122.0862462), zoom: 10.0)),
          );
        },
        initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
        markers: _markers,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeMarkers();
  }

  void initializeMarkers() {
    for (int i = 0; i < 5; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(37.4219999 + i / 20, -122.0862462 + i / 20),
            infoWindow: InfoWindow(
              title: 'Wonderful place to visit',
              snippet: '5 star rating',
            ),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {}),
      );
    }
  }
}
