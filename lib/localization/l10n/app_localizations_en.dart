import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appPurpose => 'Artevo is designed for art and aesthetics enthusiasts. It aims to bring you a daily dose of art, a poem, and a song, adding an aesthetic touch to your life.';

  @override
  String get appPurposev2 => 'Artevo is designed for art and aesthetics enthusiasts. It aims to enrich your life with an aesthetic touch by bringing you a piece of art, a poem, and a song every day.';

  @override
  String get artevoContentOfTheDay => 'Artevo Content of the Day';

  @override
  String get artevoReminder => 'Artevo Reminder';

  @override
  String get back => 'Back';

  @override
  String get contactText => 'If you would like to get detailed information, make a suggestion or complaint, make a copyright notification, provide support or become an editor, you can contact us via e-mail address or Discord.';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get contentIsNotFound => 'Content is Not Found!';

  @override
  String get continuee => 'Continue';

  @override
  String get copyEmailInfo => 'Email Address Copied!';

  @override
  String get couldNotOpenUrl => 'Could not open url!';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get edit => 'Edit';

  @override
  String get error => 'Error';

  @override
  String get errorPaintingLoaded => 'Painting not loaded!';

  @override
  String get forceUpdateText => 'A new version of the application is available. You need to update to continue.';

  @override
  String get forceUpdateTitle => 'Artevo Out of Date';

  @override
  String get goetheQuote => 'Every day one should at least hear one little song, read one good poem, see one fine painting and -- if at all possible -- speak a few sensible words.';

  @override
  String get langCode => 'en';

  @override
  String get language => 'Language';

  @override
  String get languageName => 'English';

  @override
  String get licenses => 'Licenses';

  @override
  String get more => 'more...';

  @override
  String get notificationDescriptionText => 'Once a day, whenever you want.';

  @override
  String get notificationPermissionText => 'In order for the notification feature to be turned on, you must allow it from the settings.\n\nSettings > Artevo > Notifications';

  @override
  String notificationTimeDescription(Object hour, Object min) {
    return 'The reminder is set for $hour:$min.';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get other => 'Other';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get rateArtevo => 'Rate Artevo';

  @override
  String get settings => 'Settings';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get termsOfUseToContinue => 'If you continue to use the application, you are deemed to have accepted the \'Privacy Policy\' and \'Terms of Use\'.';

  @override
  String unknowErrorText(Object mailAdress) {
    return 'Unknown error occurred. Please try again. If the error persists, please contact us Mail: $mailAdress';
  }

  @override
  String get welcome => 'Welcome';
}
