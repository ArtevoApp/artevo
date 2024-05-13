import '../constants/text_styles.dart';
import 'custom_dropdown.dart';
import '../../localization/app_localizations_context.dart';
import '../../localization/l10n/app_localizations.dart';
import '../../services/cache/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedLanguageProvider =
    StateProvider.autoDispose<Locale?>((ref) => UserDataManager.getLocale());

class LanguageSelectWithDropdownWidget extends StatelessWidget {
  const LanguageSelectWithDropdownWidget(
      {super.key, required this.isSmallWidget});

  final bool isSmallWidget;

  @override
  Widget build(BuildContext context) {
    return isSmallWidget
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${context.loc.language}:", style: TextStyles.body),
              langDropdown()
            ],
          )
        : ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(context.loc.language, style: TextStyles.body),
            trailing: langDropdown(),
          );
  }

  Widget langDropdown() {
    return Consumer(builder: (context, ref, child) {
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
    });
  }
}
