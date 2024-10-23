import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCoordinatesFromAddress(String address) async {
  List<Location> locations = await locationFromAddress(address);
  return Position(latitude: locations.first.latitude, longitude: locations.first.longitude, timestamp: DateTime.now(), // Current time as a default timestamp
  accuracy: 1.0, // Default accuracy in meters
  altitude: 0.0, // Default altitude in meters
  altitudeAccuracy: 1.0, // Default altitude accuracy in meters
  heading: 0.0, // Default heading in degrees
  headingAccuracy: 1.0, // Default heading accuracy in degrees
  speed: 0.0, // Default speed in m/s
  speedAccuracy: 1.0, // Default speed accuracy in m/s
  );
}