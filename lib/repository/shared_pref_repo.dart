import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_options/repository/abstract_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepo extends AbstractSettings {
  static late final SharedPreferences _prefs;
  static const String _localeKey = 'language_code';
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPrefRepo();

  @override
  Future<void> saveThemeMode(bool isDarkMode) async {
    await _prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  bool getThemeMode() {
    return _prefs.getBool('isDarkMode') ?? false;
  }

  @override
  Future<void> saveLocale(String locale) async {
    await _prefs.setString(_localeKey, locale);
  }

  @override
  String getLocale() {
    return _prefs.getString(_localeKey) ?? 'en';
  }

  @override
  Future<void> saveFlag(bool isFlag) async {
    await _prefs.setBool('isFlag', isFlag);
  }

  @override
  bool getFlag() {
    return _prefs.getBool('isFlag') ?? false;
  }
}

final sharedPrefRepoProvider = Provider<SharedPrefRepo>((ref) {
  return SharedPrefRepo();
});
