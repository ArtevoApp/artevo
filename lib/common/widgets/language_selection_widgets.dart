import 'package:ionicons/ionicons.dart';
import 'custom_dropdown.dart';
import '../../localization/app_localizations_context.dart';
import '../../localization/l10n/app_localizations.dart';
import '../../services/cache/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedLanguageProvider =
    StateProvider.autoDispose<Locale?>((ref) => UserDataManager.getLocale());

class LanguageSelectWithDropdownWidget extends StatelessWidget {
  const LanguageSelectWithDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(context.loc.language),
      trailing: Consumer(
        builder: (context, ref, child) {
          return SizedBox(
            width: 100,
            child: CustomDropdown(
              menuItems: AppLocalizations.supportedLocales
                  .map((e) => LanguageHelper.languageName(e.toLanguageTag()))
                  .toList(),
              onChanged: (p0) {
                if (p0 != null) {
                  final Locale locale =
                      LanguageHelper.fromLanguageName(p0.toString());
                  ref.read(selectedLanguageProvider.notifier).state = locale;
                  UserDataManager.instance.setLocale(locale.languageCode);
                }
              },
              value: context.loc.languageName,
            ),
          );
        },
      ),
    );
  }
}

class LanguageSelectionWithPopupWidget extends StatelessWidget {
  const LanguageSelectionWithPopupWidget({super.key, this.iconColor});

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return PopupMenuButton(
        position: PopupMenuPosition.under,
        tooltip: context.loc.language,
        icon: const Icon(Ionicons.language),
        iconColor: iconColor,
        itemBuilder: (context) => AppLocalizations.supportedLocales
            .map((e) => PopupMenuItem(
                value: e.languageCode,
                child: ListTile(
                  title: Text(LanguageHelper.languageName(e.toLanguageTag())),
                )))
            .toList(),
        onSelected: (p0) {
          ref.read(selectedLanguageProvider.notifier).state = Locale(p0);
          UserDataManager.instance.setLocale(p0);
        },
      );
    });
  }
}
