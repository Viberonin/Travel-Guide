import 'package:geolocator/geolocator.dart';

class PositionServices {
  final String apiKey = 'AIzaSyC7UgbSdUXcPdMnVQoYSNniKs8VvxDiw0s';
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';

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
}
