import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> determinePosition() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return null;
    // }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            timeLimit: Duration(seconds: 10));
        return position;
      } catch (e) {
        return null; // Handle the exception here or log it.
      }
    }

    return null;
  }
}
