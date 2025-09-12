import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // Define keys for all storage data
  static const _usernameKey = 'username';
  static const _nameKey = 'name';
  static const _ageKey = 'age';
  static const _roleKey = 'role';
  static const _passwordKey = 'password';
  static const _latitudeKey = 'latitude';
  static const _longitudeKey = 'longitude';

  // --- Write Operations ---

  // Save username
  Future<void> saveUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  // Save full user data during signup
  Future<void> saveUserData({
    required String username,
    required String name,
    required String age,
    required String role,
    required String password,
  }) async {
    await _storage.write(key: _usernameKey, value: username);
    await _storage.write(key: _nameKey, value: name);
    await _storage.write(key: _ageKey, value: age);
    await _storage.write(key: _roleKey, value: role);
    await _storage.write(key: _passwordKey, value: password);
  }

  // Save location data
  Future<void> saveLocation(double latitude, double longitude) async {
    await _storage.write(key: _latitudeKey, value: latitude.toString());
    await _storage.write(key: _longitudeKey, value: longitude.toString());
  }

  // --- Read Operations ---

  // Read username
  Future<String?> readUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  // Read role (for login navigation logic)
  Future<String?> readRole() async {
    return await _storage.read(key: _roleKey);
  }

  // Read name
  Future<String?> readName() async {
    return await _storage.read(key: _nameKey);
  }

  // Read age
  Future<String?> readAge() async {
    return await _storage.read(key: _ageKey);
  }

  // Read password
  Future<String?> readPassword() async {
    return await _storage.read(key: _passwordKey);
  }

  // Read location
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

  // Delete location data
  Future<void> deleteLocation() async {
    await _storage.delete(key: _latitudeKey);
    await _storage.delete(key: _longitudeKey);
  }

  // Delete user data
  Future<void> deleteUserData() async {
    await _storage.delete(key: _usernameKey);
    await _storage.delete(key: _nameKey);
    await _storage.delete(key: _ageKey);
    await _storage.delete(key: _roleKey);
    await _storage.delete(key: _passwordKey);
  }

  // Delete all data
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
