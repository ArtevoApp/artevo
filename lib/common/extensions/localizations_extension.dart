import '../../core/localization/l10n/app_localizations.dart';

extension LocalizationsExtension on AppLocalizations {
  bool get isTr => localeName == "tr";
  bool get isEn => localeName == "en";
}
