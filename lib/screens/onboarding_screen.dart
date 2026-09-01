import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_storage_options/approuts.dart';
import 'package:local_storage_options/l10n/app_localizations.dart';
import 'package:local_storage_options/onboarding_data.dart';
import 'package:local_storage_options/providers/setting_provider.dart';
import 'package:local_storage_options/widgets/lang_selector.dart';
import 'package:local_storage_options/widgets/onboarding_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerWidget {
  final pageController = PageController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingprovider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Page View Section
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: List.generate(
                    OnboardingData.images.length,
                    (index) => OnboardingImage(
                      imagePath: OnboardingData.images[index],
                      title: OnboardingData.getTitles(context)[index],
                      subtitle: OnboardingData.getDescriptions(context)[index],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Dynamic Smooth Page Indicator
              SmoothPageIndicator(
                controller: pageController,
                count: OnboardingData.images.length,
                effect: WormEffect(
                  activeDotColor: theme.primaryColor,
                  dotColor: isDark
                      ? const Color(0xFF4A4A4A)
                      : const Color(0xFFE0E0E0),
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),

              const SizedBox(height: 32),

              // Action Button (uses l10n.getStarted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  ref.read(settingprovider.notifier).saveFlag(true);
                   context.go(Approuts.welcome); // Navigate to the home screen
                  },
                  child: Text(l10n.getStarted),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}