import 'package:ionicons/ionicons.dart';
import '../global_variables/language.dart';
import 'custom_dropdown.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/localization/l10n/app_localizations.dart';
import '../../services/cache/user_data_manager.dart';
import 'package:flutter/material.dart';

class LanguageSelectWithDropdownWidget extends StatelessWidget {
  const LanguageSelectWithDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(context.loc.language),
      trailing: SizedBox(
        width: 100,
        child: CustomDropdown(
          menuItems: AppLocalizations.supportedLocales
              .map((e) => LanguageHelper.languageName(e.toLanguageTag()))
              .toList(),
          onChanged: (p0) {
            if (p0 != null) {
              final Locale locale =
                  LanguageHelper.fromLanguageName(p0.toString());
              localeController.value = locale;
              UserDataManager.instance.setLocale(locale.languageCode);
            }
          },
          value: context.loc.languageName,
        ),
      ),
    );
  }
}

class LanguageSelectionWithPopupWidget extends StatelessWidget {
  const LanguageSelectionWithPopupWidget({super.key, this.iconColor});

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
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
        localeController.value = Locale(p0);
        UserDataManager.instance.setLocale(p0);
      },
    );
  }
}
