import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getCurrentLocation() async {
    // Check if service is enabled
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null; // service not enabled
      }
    }

    // Check permission
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null; // permission denied
      }
    }

    // Get location
    return await _location.getLocation();
  }
}
