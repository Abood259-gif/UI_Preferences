abstract class AbstractSettings {
  Future<void> saveThemeMode(bool isDarkMode);
  bool getThemeMode();
  Future<void> saveLocale(String locale);
  String getLocale();
  Future<void> saveFlag(bool isFlag);
  bool getFlag();
}
