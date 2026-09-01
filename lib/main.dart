import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_options/approuts.dart';
import 'package:local_storage_options/l10n/app_localizations.dart';
import 'package:local_storage_options/providers/setting_provider.dart';
import 'package:local_storage_options/repository/shared_pref_repo.dart';
import 'package:local_storage_options/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefRepo.init(); // Initialize SharedPreferences
  runApp(ProviderScope(
    child: const MainApp()
    ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final settingmode = ref.watch(settingprovider);
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
themeMode: settingmode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      locale:  Locale(settingmode.isArabic ? 'ar' : 'en'), 
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router(
        settingmode.isFlag ? Approuts.welcome : Approuts.onboarding
      ), // Use the router configuration
    );
  }
}
