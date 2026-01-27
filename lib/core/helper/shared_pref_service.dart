import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SharedPrefService {
  SharedPrefService._();
static const String storedToken="token";
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> setSecuredString(String key, String value) async {
    debugPrint('SecureStorage : set $key = $value');
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    debugPrint('SecureStorage : get $key');
    return await _secureStorage.read(key: key) ?? '';
  }


  static Future<void> clearAllSecuredData() async {
    debugPrint('SecureStorage : cleared all');
    await _secureStorage.deleteAll();
  }
}
