import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create an instance of the storage
  final _storage = const FlutterSecureStorage();

  // Define keys for the data you want to store
  static const _usernameKey = 'username';

  // --- Write Operations ---

  Future<void> saveUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  // --- Read Operations ---

  Future<String?> readUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  // // --- Delete Operations ---

  // Future<void> deleteUsername() async {
  //   await _storage.delete(key: _usernameKey);
  // }

  // Future<void> deleteAllData() async {
  //   await _storage.deleteAll();
  // }
}
