

import 'package:local_storage_options/repository/shared_pref_repo.dart';
import 'package:riverpod/riverpod.dart';


class SettingsState {
  final bool isDarkMode;
  final bool isArabic;
  final bool isFlag;
  SettingsState({required this.isDarkMode , required this.isArabic , required this.isFlag});
}


class SettingNotifire extends StateNotifier<SettingsState> {
   final Ref ref;

  SettingNotifire(this.ref) : super(
    SettingsState(
      isDarkMode: ref.read(sharedPrefRepoProvider).getThemeMode() , 
      isArabic: ref.read(sharedPrefRepoProvider).getLocale() == 'ar',
      isFlag: ref.read(sharedPrefRepoProvider).getFlag()
      )
    );

  Future<void> toggleTheme(bool isDarkMode) async {
    final sharedPrefRepo = ref.read(sharedPrefRepoProvider);
     await sharedPrefRepo.saveThemeMode(isDarkMode);
   if(isDarkMode) {
      state = SettingsState(
        isDarkMode: true , 
        isArabic: sharedPrefRepo.getLocale() == 'ar',
        isFlag: sharedPrefRepo.getFlag()
        );
    } else {
      state = SettingsState(
        isDarkMode: false , 
        isArabic: sharedPrefRepo.getLocale() == 'ar',
        isFlag: sharedPrefRepo.getFlag()
        );
    }
  }

Future<void> changeLanguage(String languageCode) async {
    final isArabic = languageCode == 'ar';
    if (state.isArabic == isArabic) return; 

    final sharedPrefRepo = ref.read(sharedPrefRepoProvider);
    await sharedPrefRepo.saveLocale(languageCode);

    state = SettingsState(
      isDarkMode: sharedPrefRepo.getThemeMode(), 
      isArabic: isArabic , 
      isFlag: sharedPrefRepo.getFlag()
      );
  }

Future<void> saveFlag(bool isFlag) async {
    final sharedPrefRepo = ref.read(sharedPrefRepoProvider);
    await sharedPrefRepo.saveFlag(isFlag);
    state = SettingsState(
      isDarkMode: sharedPrefRepo.getThemeMode(), 
      isArabic: sharedPrefRepo.getLocale() == 'ar' , 
      isFlag: isFlag
      );
  }
}

final settingprovider = StateNotifierProvider<SettingNotifire, SettingsState>((ref) {
  return SettingNotifire(ref);
});