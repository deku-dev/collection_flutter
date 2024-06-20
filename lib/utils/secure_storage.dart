import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveApiKey(String apiKey) async {
    await _storage.write(key: 'api_key', value: apiKey);
  }

  Future<void> saveApiSecret(String apiSecret) async {
    await _storage.write(key: 'api_secret', value: apiSecret);
  }

  Future<String?> getApiKey() async {
    return await _storage.read(key: 'api_key');
  }

  Future<String?> getApiSecret() async {
    return await _storage.read(key: 'api_secret');
  }

  Future<void> deleteApiKey() async {
    await _storage.delete(key: 'api_key');
  }

  Future<void> deleteApiSecret() async {
    await _storage.delete(key: 'api_secret');
  }
}
