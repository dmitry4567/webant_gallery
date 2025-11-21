import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';

class TokenManager {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  TokenManager({required this.sharedPreferences, required this.secureStorage});

  String? getAccessToken() {
    return sharedPreferences.getString(AppConstants.jwtKey);
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: AppConstants.refreshKey);
  }

  Future<void> setAccessToken(String value) async {
    await sharedPreferences.setString(AppConstants.jwtKey, value);
  }

  Future<void> setRefreshToken(String value) async {
    return await secureStorage.write(
      key: AppConstants.refreshKey,
      value: value,
    );
  }

  Future<void> clearTokens() async {
    await sharedPreferences.remove(AppConstants.jwtKey);
    await secureStorage.delete(key: AppConstants.refreshKey);
  }
}
