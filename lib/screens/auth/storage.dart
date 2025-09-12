import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // Define keys
  static const _usernameKey = 'username';
  static const _nameKey = 'name';
  static const _ageKey = 'age';
  static const _roleKey = 'role';
  static const _passwordKey = 'password';  // Optional, if you want to store password

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

  // Read username
  Future<String?> readUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  // Read role (for login navigation logic)
  Future<String?> readRole() async {
    return await _storage.read(key: _roleKey);
  }

  // You can create getters for other data if needed
  Future<String?> readName() async {
    return await _storage.read(key: _nameKey);
  }

  Future<String?> readAge() async {
    return await _storage.read(key: _ageKey);
  }

  Future<String?> readPassword() async {
    return await _storage.read(key: _passwordKey);
  }

  // Optional: Delete all user data
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}