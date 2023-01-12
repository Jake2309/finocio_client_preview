import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

class SecureStorageManager {
  final FlutterSecureStorage _secureStorage;

  SecureStorageManager(this._secureStorage);

  Future<void> saveKey(String dataKey, val) async =>
      await _secureStorage.write(key: dataKey, value: val);

  Future<dynamic> readKey(String dataKey) async =>
      await _secureStorage.read(key: dataKey);
}
