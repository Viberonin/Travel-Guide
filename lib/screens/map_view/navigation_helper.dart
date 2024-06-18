import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin, min, max;

class NavigationHelper {
  static Future<void> showPolylineAndInfo({
    required BuildContext context,
    required GoogleMapController mapController,
    required LatLng startLatLng,
    required LatLng endLatLng,
    required Function(List<Polyline>) updatePolylines,
  }) async {
    final routeInfo = await _getRouteInfo(startLatLng, endLatLng);
    if (routeInfo == null) {
      // Handle the error
      return;
    }

    Polyline polyline = Polyline(
      polylineId: PolylineId('route'),
      points: routeInfo['polylinePoints'],
      color: Colors.blue,
      width: 5,
    );

    updatePolylines([polyline]);

    // Move the camera to fit both points
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(startLatLng.latitude, endLatLng.latitude),
        min(startLatLng.longitude, endLatLng.longitude),
      ),
      northeast: LatLng(
        max(startLatLng.latitude, endLatLng.latitude),
        max(startLatLng.longitude, endLatLng.longitude),
      ),
    );

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));

    // Display distance and time info
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          iconColor: Colors.pink,
          title: Text('Trip Information', style: GoogleFonts.poppins()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Distance: ${routeInfo['distance']}', style: GoogleFonts.poppins()),
              Text('Estimated Time: ${routeInfo['duration']}', style: GoogleFonts.poppins()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  static Future<Map<String, dynamic>?> _getRouteInfo(
      LatLng startLatLng, LatLng endLatLng) async {
    const apiKey = 'AIzaSyC7UgbSdUXcPdMnVQoYSNniKs8VvxDiw0s';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startLatLng.latitude},${startLatLng.longitude}&destination=${endLatLng.latitude},${endLatLng.longitude}&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['routes'] != null && json['routes'].isNotEmpty) {
        final route = json['routes'][0];
        final polyline = route['overview_polyline']['points'];
        final distance = route['legs'][0]['distance']['text'];
        final duration = route['legs'][0]['duration']['text'];
        return {
          'polylinePoints': _convertToLatLng(_decodePolyline(polyline)),
          'distance': distance,
          'duration': duration,
        };
      }
    } else {
      print('Failed to load directions: ${response.statusCode}');
    }
    return null;
  }

  static List<LatLng> _convertToLatLng(List<dynamic> points) {
    final result = <LatLng>[];
    for (var point in points) {
      result.add(LatLng(point[0], point[1]));
    }
    return result;
  }

  static List<List<double>> _decodePolyline(String encoded) {
    List<List<double>> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add([(lat / 1E5).toDouble(), (lng / 1E5).toDouble()]);
    }
    return poly;
  }
}
