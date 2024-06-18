import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelguide/screens/map_view/map_view_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ViewInMapButtonTest extends StatefulWidget {
  const ViewInMapButtonTest({super.key});

  @override
  State<ViewInMapButtonTest> createState() => _ViewInMapButtonTestState();
}

class _ViewInMapButtonTestState extends State<ViewInMapButtonTest> {
  String locationMsg = "Coordinates of the current user's position: ";
  late String lat;
  late String long;
  Position? _currentLocation;

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission;
    
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Services are disabled.");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Not allowed to access current location.");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMsg = 'Latitude: $lat \n Longitude: $long';
      });
    });
  }

  Future<void> _openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not launch $googleURL';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geolocator Test"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();
                print("${_currentLocation}");
              },
              child: Text("Get Current Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // _openMap(lat, long);
                Get.to(MapViewScreen());
              },
              child: Text("Open Google Maps"),
            ),
          ],
        ),
      ),
    );
  }
}
