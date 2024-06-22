import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelguide/models/destination_model.dart';
import 'package:travelguide/screens/map_view/finished_trip_screen.dart';
import 'package:travelguide/screens/map_view/navigation_helper.dart';

class MapViewScreen extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  final DestinationModel destination;

  MapViewScreen(
      {super.key,
      required this.initialLatitude,
      required this.initialLongitude,
      required this.destination});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  // final CameraPosition _cameraPosition = CameraPosition(
  //     target: LatLng(-7.275623601294575, 112.79371278128939), zoom: 13.0);
  late CameraPosition _cameraPosition;

  MapType _currentMapType = MapType.terrain;
  final ValueNotifier<MapType> _mapTypeNotifier =
      ValueNotifier<MapType>(MapType.normal);
  Completer<GoogleMapController> _mapController = Completer();

  final List<Marker> _markers = [];
  final List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(
      target: LatLng(widget.initialLatitude, widget.initialLongitude),
      zoom: 14.0,
    );

    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(widget.initialLatitude, widget.initialLongitude),
        infoWindow: InfoWindow(
          title: 'Lokasi Tempat Wisata',
        ),
      ),
    );
  }

  void _updatePolylines(List<Polyline> newPolylines) {
    setState(() {
      _polylines.clear();
      _polylines.addAll(newPolylines);
    });
  }

  void _addMarkerAndMoveCamera(double latitude, double longitude) async {
    final GoogleMapController controller = await _mapController.future;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('newLocation'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'Selected Location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void dispose() {
    _mapTypeNotifier.dispose();
    super.dispose();
  }

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Services are disabled.");
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    // Get the current position
    return await Geolocator.getCurrentPosition();
  }

  double _bottomSheetHeight = 0.2; // Initial height

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
              initialCameraPosition: _cameraPosition,
              mapType: _currentMapType,
              markers: Set<Marker>.of(_markers),
              polylines: Set<Polyline>.of(_polylines),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            ),
            Positioned(
              top: 20,
              left: 10,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF17B0C2),
                heroTag: 'backButton',
                onPressed: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: ValueListenableBuilder<MapType>(
                valueListenable: _mapTypeNotifier,
                builder: (context, mapType, _) {
                  return FloatingActionButton(
                    backgroundColor: Color(0xFF17B0C2),
                    heroTag: 'mapTypeButton',
                    onPressed: null,
                    child: PopupMenuButton<MapType>(
                      icon: Icon(Iconsax.map),
                      onSelected: (MapType result) {
                        _mapTypeNotifier.value = result;
                        setState(() {
                          _currentMapType = result;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MapType>>[
                        PopupMenuItem<MapType>(
                          value: MapType.normal,
                          child: Row(
                            children: [
                              if (mapType == MapType.normal)
                                Icon(Icons.check, color: Colors.blue),
                              Text('Normal'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MapType>(
                          value: MapType.hybrid,
                          child: Row(
                            children: [
                              if (mapType == MapType.hybrid)
                                Icon(Icons.check, color: Colors.blue),
                              Text('Hybrid'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MapType>(
                          value: MapType.satellite,
                          child: Row(
                            children: [
                              if (mapType == MapType.satellite)
                                Icon(Icons.check, color: Colors.blue),
                              Text('Satellite'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MapType>(
                          value: MapType.terrain,
                          child: Row(
                            children: [
                              if (mapType == MapType.terrain)
                                Icon(Icons.check, color: Colors.blue),
                              Text('Terrain'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            dragScrollSheet(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom:
                      MediaQuery.of(context).size.height * _bottomSheetHeight +
                          2,
                  right: 10,
                ),
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF17B0C2),
                  heroTag: 'getLocationButton',
                  onPressed: () async {
                    Position position = await _getCurrentLocation();
                    LatLng currentPosition =
                        LatLng(position.latitude, position.longitude);
                    setState(() {
                      _markers.add(
                        Marker(
                          markerId: MarkerId('2'),
                          position: currentPosition,
                          infoWindow: InfoWindow(
                            title: 'Lokasi Saya Saat Ini',
                          ),
                        ),
                      );
                    });
                    CameraPosition cameraPosition = CameraPosition(
                      target: currentPosition,
                      zoom: 14,
                    );

                    final GoogleMapController controller =
                        await _mapController.future;
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(cameraPosition));
                  },
                  child: Icon(Icons.my_location),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DraggableScrollableSheet dragScrollSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.25, // Initially occupy 25% of the screen height
      minChildSize: 0.15, // Minimum height
      maxChildSize: 0.25, // Maximum height
      builder: (BuildContext context, ScrollController scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            setState(() {
              _bottomSheetHeight = notification.extent;
            });
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 76, 233, 238),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 10, right: 15),
              child: Column(
                children: [
                  // Departure
                  Row(
                    children: [
                      Container(
                        width: 40,
                        child: Column(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 20,
                              color: Colors.black,
                            ),
                            Container(
                              height: 20,
                              width: 2,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Lokasi Saya Saat Ini",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                  // Destination
                  Row(
                    children: [
                      Container(
                        width: 40,
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: 2,
                              color: Colors.grey,
                            ),
                            Icon(
                              Icons.circle,
                              size: 20,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.destination.title,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(FinishedTripScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Colors.black), // Border color
                              ),
                            ),
                            child: Text(
                              'Finish Trip',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 10), // Add some space between the buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final GoogleMapController controller =
                                  await _mapController.future;
                              NavigationHelper.showPolylineAndInfo(
                                context: context,
                                mapController: controller,
                                startLatLng: LatLng(widget.initialLatitude,
                                    widget.initialLongitude),
                                endLatLng: _markers.last.position,
                                updatePolylines: _updatePolylines,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Navigate',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
