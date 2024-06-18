import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-7.275623601294575, 112.79371278128939), zoom: 13.0);

  MapType _currentMapType = MapType.normal;
  final ValueNotifier<MapType> _mapTypeNotifier = ValueNotifier<MapType>(MapType.normal);
  Completer<GoogleMapController> _mapController = Completer();

  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(20.42796133580664, 75.885749655962),
      infoWindow: InfoWindow(
        title: 'Predetermined Location',
      ),
    ),
  ];

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
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            ),
            Positioned(
              top: 20,
              left: 10,
              child: FloatingActionButton(
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
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
                        PopupMenuItem<MapType>(
                          value: MapType.normal,
                          child: Row(
                            children: [
                              if (mapType == MapType.normal) Icon(Icons.check, color: Colors.blue),
                              Text('Normal'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MapType>(
                          value: MapType.hybrid,
                          child: Row(
                            children: [
                              if (mapType == MapType.hybrid) Icon(Icons.check, color: Colors.blue),
                              Text('Hybrid'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MapType>(
                          value: MapType.satellite,
                          child: Row(
                            children: [
                              if (mapType == MapType.satellite) Icon(Icons.check, color: Colors.blue),
                              Text('Satellite'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MapType>(
                          value: MapType.terrain,
                          child: Row(
                            children: [
                              if (mapType == MapType.terrain) Icon(Icons.check, color: Colors.blue),
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
            DraggableScrollableSheet(
              initialChildSize: 0.2, // Initially occupy 20% of the screen height
              minChildSize: 0.2, // Minimum height
              maxChildSize: 0.4, // Maximum height
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: 2, // Assume 'places' is a list containing your data
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        child: Column(
                                          children: [
                                            if (index != 0) 
                                              Container(
                                                height: 20,
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                            Icon(
                                              Icons.circle,
                                              size: 10,
                                              // color: index == places.length - 1 ? Colors.red : Colors.black,
                                              color: index == 2 - 1 ? Colors.red : Colors.black,
                                            ),
                                            if (index != 2 - 1) 
                                              Container(
                                                height: 20,
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // places[index].name,
                                            "Politeknik Elektronika Negeri Surabaya",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            // places[index].info1,
                                            "Politeknik Elektronika Negeri Surabaya",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            // places[index].info2,
                                            "Politeknik Elektronika Negeri Surabaya",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (index != 2 - 1) 
                                    Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Finish Trip Action
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.black), // Border color
                                  ),
                                ),
                                child: Text(
                                  'Finish Trip',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate Action
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Navigate',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * _bottomSheetHeight + 2,
                  right: 10,
                ),
                child: FloatingActionButton(
                  heroTag: 'getLocationButton',
                  onPressed: () async {
                    Position position = await _getCurrentLocation();
                    LatLng currentPosition = LatLng(position.latitude, position.longitude);
                    setState(() {
                      _markers.add(
                        Marker(
                          markerId: MarkerId('2'),
                          position: currentPosition,
                          infoWindow: InfoWindow(
                            title: 'My Current Location',
                          ),
                        ),
                      );
                    });
                    CameraPosition cameraPosition = CameraPosition(
                      target: currentPosition,
                      zoom: 14,
                    );

                    final GoogleMapController controller = await _mapController.future;
                    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
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
}
