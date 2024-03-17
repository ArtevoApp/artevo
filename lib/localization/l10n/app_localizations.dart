import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @addAComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get addAComment;

  /// No description provided for @appPurpose.
  ///
  /// In en, this message translates to:
  /// **'Artevo aims to add an aesthetic touch to your life by bringing you a work of art, a poem and a song every day.'**
  String get appPurpose;

  /// No description provided for @appPurposev2.
  ///
  /// In en, this message translates to:
  /// **'Artevo is designed for art and aesthetics enthusiasts. It aims to enrich your life with an aesthetic touch by bringing you a piece of art, a poem, and a song every day.'**
  String get appPurposev2;

  /// No description provided for @artevoContentOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Artevo Content of the Day'**
  String get artevoContentOfTheDay;

  /// No description provided for @artevoReminder.
  ///
  /// In en, this message translates to:
  /// **'Artevo Reminder'**
  String get artevoReminder;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @contactText.
  ///
  /// In en, this message translates to:
  /// **'If you would like to get detailed information, make a suggestion or complaint, make a copyright notification, provide support or become an editor, you can contact us via e-mail address or Discord.'**
  String get contactText;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contentIsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Content is Not Found!'**
  String get contentIsNotFound;

  /// No description provided for @continuee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuee;

  /// No description provided for @copyEmailInfo.
  ///
  /// In en, this message translates to:
  /// **'Email Address Copied!'**
  String get copyEmailInfo;

  /// No description provided for @couldNotOpenUrl.
  ///
  /// In en, this message translates to:
  /// **'Could not open url!'**
  String get couldNotOpenUrl;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @dataIsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Data is not found!'**
  String get dataIsNotFound;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorPaintingLoaded.
  ///
  /// In en, this message translates to:
  /// **'Painting not loaded!'**
  String get errorPaintingLoaded;

  /// No description provided for @forceUpdateText.
  ///
  /// In en, this message translates to:
  /// **'A new version of the application is available. You need to update to continue.'**
  String get forceUpdateText;

  /// No description provided for @forceUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Artevo Out of Date'**
  String get forceUpdateTitle;

  /// No description provided for @goetheQuote.
  ///
  /// In en, this message translates to:
  /// **'Every day one should at least hear one little song, read one good poem, see one fine painting and -- if at all possible -- speak a few sensible words.'**
  String get goetheQuote;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @imageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Image not found!'**
  String get imageNotFound;

  /// No description provided for @langCode.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get langCode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more...'**
  String get more;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @notificationDescriptionText.
  ///
  /// In en, this message translates to:
  /// **'Once a day, whenever you want.'**
  String get notificationDescriptionText;

  /// No description provided for @notificationPermissionText.
  ///
  /// In en, this message translates to:
  /// **'In order for the notification feature to be turned on, you must allow it from the settings.\n\nSettings > Artevo > Notifications'**
  String get notificationPermissionText;

  /// No description provided for @notificationTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'The reminder is set for {hour}:{min}.'**
  String notificationTimeDescription(Object hour, Object min);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @painting.
  ///
  /// In en, this message translates to:
  /// **'Painting'**
  String get painting;

  /// No description provided for @poem.
  ///
  /// In en, this message translates to:
  /// **'Poem'**
  String get poem;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @rateArtevo.
  ///
  /// In en, this message translates to:
  /// **'Rate Artevo'**
  String get rateArtevo;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @submitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get submitFeedback;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @termsOfUseToContinue.
  ///
  /// In en, this message translates to:
  /// **'If you continue to use the application, you are deemed to have accepted the \'Privacy Policy\' and \'Terms of Use\'.'**
  String get termsOfUseToContinue;

  /// No description provided for @thanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks!'**
  String get thanks;

  /// No description provided for @thanksForYourFeedback.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your feedback.'**
  String get thanksForYourFeedback;

  /// No description provided for @unknowErrorText.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred. Please try again. If the error persists, please contact us Mail: {mailAdress}'**
  String unknowErrorText(Object mailAdress);

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @wouldYouRateTodaysContent.
  ///
  /// In en, this message translates to:
  /// **'Would you rate today\'s content?'**
  String get wouldYouRateTodaysContent;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
