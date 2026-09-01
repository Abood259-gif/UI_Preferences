

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_options/l10n/app_localizations.dart';
import 'package:local_storage_options/providers/setting_provider.dart';
import 'package:local_storage_options/widgets/lang_selector.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
      final themeMode = ref.watch(settingprovider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Switch(
              value: themeMode.isDarkMode == true,
              onChanged: (value) =>
                  ref.read(settingprovider.notifier).toggleTheme(value),
            ),
            const SizedBox(width: 10),
            // Localized Theme Switch Label
            Text(
              themeMode.isDarkMode == true ? l10n.darkMode : l10n.lightMode,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: LanguageSelector(),
          ),
        ],
      ),
      body: Center(
        child: Text(
         l10n.welcomeMessage, 
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}