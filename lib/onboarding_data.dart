import 'package:flutter/material.dart';
import 'package:local_storage_options/l10n/app_localizations.dart';

class OnboardingData {
  static const List<String> images = [
    'assets/images/search_person.png',
    'assets/images/apply_person.png',
    'assets/images/fav_person.png',
  ];

  static List<String> getTitles(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.onboardingTitle1,
      l10n.onboardingTitle2,
      l10n.onboardingTitle3,
    ];
  }

  static List<String> getDescriptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.onboardingDesc1, l10n.onboardingDesc2, l10n.onboardingDesc3];
  }
}
