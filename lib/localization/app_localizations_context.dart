import 'l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

///
/// To use "context.loc" instead of "AppLocalizations.of(context)"
///
extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

class LanguageHelper {
  const LanguageHelper._();

  static String languageName(String langTag) {
    switch (langTag) {
      case 'tr':
        return "Türkçe";
      case 'en':
        return "English";
      default:
        return "Unknow";
    }
  }

  static Locale fromLanguageName(String langName) {
    switch (langName) {
      case 'Türkçe':
        return const Locale('tr');
      case 'English':
        return const Locale('en');
      default:
        return const Locale('en');
    }
  }
}
