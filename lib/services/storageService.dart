import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create an instance of the storage
  final _storage = const FlutterSecureStorage();

  // Define keys for the data you want to store
  static const _usernameKey = 'username';
  static const _latitudeKey = 'latitude';
  static const _longitudeKey = 'longitude';

  // --- Write Operations ---

  Future<void> saveUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  Future<void> saveLocation(double latitude, double longitude) async {
    await _storage.write(key: _latitudeKey, value: latitude.toString());
    await _storage.write(key: _longitudeKey, value: longitude.toString());
  }

  // --- Read Operations ---

  Future<String?> readUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  Future<Map<String, double>?> readLocation() async {
    final lat = await _storage.read(key: _latitudeKey);
    final lng = await _storage.read(key: _longitudeKey);

    if (lat != null && lng != null) {
      return {
        'latitude': double.parse(lat),
        'longitude': double.parse(lng),
      };
    }
    return null;
  }

  // --- Delete Operations ---

  Future<void> deleteLocation() async {
    await _storage.delete(key: _latitudeKey);
    await _storage.delete(key: _longitudeKey);
  }

  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
