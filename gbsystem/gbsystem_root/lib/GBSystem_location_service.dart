import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'GBSystem_place_model.dart';
import 'GBSystem_position_with_error_model.dart';
import 'api.dart';

class LocationService {
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // added
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("service enabled : $serviceEnabled");
    if (!serviceEnabled) {
      return null;
    }

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

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 10));
        print(position.latitude);
        return position;
      } catch (e) {
        // throw Exception(
        //     "Time out for Localisation Check your network and try again");
        // return null; // Handle the exception here or log it.
        return null;
      }
    }

    return null;
  }

  Future<PositionWithErrorModel> determinePositionWithErrorsPointage() async {
    bool serviceEnabled;
    LocationPermission permission;

    // added
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("service enabled : $serviceEnabled");
    if (!serviceEnabled) {
      return PositionWithErrorModel(isPermissionNotGranted: false, isPhoneDontSupport: true, isTimeOut: false, messageErr: null, position: null);
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return PositionWithErrorModel(isPermissionNotGranted: true, isPhoneDontSupport: false, isTimeOut: false, messageErr: null, position: null);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return PositionWithErrorModel(isPermissionNotGranted: true, isPhoneDontSupport: false, isTimeOut: false, messageErr: null, position: null);
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 10));
        print(position.latitude);
        print(position.longitude);

        return PositionWithErrorModel(isPermissionNotGranted: false, isPhoneDontSupport: false, isTimeOut: false, messageErr: null, position: position);
      } catch (e) {
        // throw Exception(
        //     "Time out for Localisation Check your network and try again");
        // return null; // Handle the exception here or log it.
        print(e);
        return PositionWithErrorModel(isPermissionNotGranted: false, isPhoneDontSupport: false, isTimeOut: e.toString().contains("TimeoutException"), messageErr: e.toString().contains("TimeoutException") ? "" : e.toString(), position: null);
      }
    }
    return PositionWithErrorModel(isPermissionNotGranted: false, isPhoneDontSupport: false, isTimeOut: true, messageErr: null, position: null);
  }

  Future<List<GbsystemPlaceModel>> getSuggestionsPosition(BuildContext context, {required String search}) async {
    List<GbsystemPlaceModel> listPlaces = [];
    await Api().get(url: "https://api-adresse.data.gouv.fr/search/?q=$search&autocomplete=1").then((responseServer) {
      if (responseServer.isDataPlacesApiIsNotEmpty()) {
        listPlaces = GbsystemPlaceModel.convertDynamictoList((responseServer.data["features"] as List));
      }

      return listPlaces;
    });
    return listPlaces;
  }
}
