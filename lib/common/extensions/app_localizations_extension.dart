import '../../localization/l10n/app_localizations.dart';

extension AppLocalizationsHelper on AppLocalizations {
  bool get isTr => localeName == "tr";
  bool get isEn => localeName == "en";
}
