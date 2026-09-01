

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_options/providers/setting_provider.dart';
import 'package:local_storage_options/widgets/lang_option_button.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(settingprovider);
    final isArabic = currentLocale.isArabic ;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Arabic Button
         LanguageOptionButton(
            label: 'AR',
            isSelected: isArabic,
            onTap: () {
              if (!isArabic) {
                ref.read(settingprovider.notifier).changeLanguage('ar');
              }
            },
            activeColor: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          // English Button
          LanguageOptionButton(
            label: 'EN',
            isSelected: !isArabic,
            onTap: () {
              if (isArabic) {
                ref.read(settingprovider.notifier).changeLanguage('en');
              }
            },
            activeColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}