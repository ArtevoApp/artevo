import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/custom_dropdown.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedLanguageProvider =
    StateProvider.autoDispose<Locale?>((ref) => null);

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
              Text("${context.loc.language}:", style: TextStyles.bodyTextStyle),
              langDropdown()
            ],
          )
        : ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(context.loc.language, style: TextStyles.bodyTextStyle),
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
              ref.read(selectedLanguageProvider.notifier).state =
                  LanguageHelper.fromLanguageName(p0.toString());
            }
          },
          value: context.loc.languageName,
        ),
      );
    });
  }
}
