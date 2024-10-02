import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

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
  /// In tr, this message translates to:
  /// **'Bir yorum ekleyin...'**
  String get addAComment;

  /// No description provided for @addBookmarks.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilenler\'e Ekle'**
  String get addBookmarks;

  /// No description provided for @addQueue.
  ///
  /// In tr, this message translates to:
  /// **'Kuyruğa Ekle'**
  String get addQueue;

  /// No description provided for @addToPlaylist.
  ///
  /// In tr, this message translates to:
  /// **'Çalma Listesine Ekle'**
  String get addToPlaylist;

  /// No description provided for @appPurpose.
  ///
  /// In tr, this message translates to:
  /// **'Artevo, sizleri her gün bir sanat eseri, bir şiir ve bir şarkı ile buluşturarak hayatınıza estetik bir dokunuş katmayı amaçlar.'**
  String get appPurpose;

  /// No description provided for @appPurposev2.
  ///
  /// In tr, this message translates to:
  /// **'Artevo, sanat ve estetik tutkunları için tasarlanmıştır. Sizleri her gün bir sanat eseri, bir şiir ve bir şarkı ile buluşturarak hayatınıza estetik bir dokunuş katmayı amaçlar.'**
  String get appPurposev2;

  /// No description provided for @artevoContentOfTheDay.
  ///
  /// In tr, this message translates to:
  /// **'Artevo Günün İçeriği'**
  String get artevoContentOfTheDay;

  /// No description provided for @artevoReminder.
  ///
  /// In tr, this message translates to:
  /// **'Artevo Hatırlatıcı'**
  String get artevoReminder;

  /// No description provided for @artevoPlaylists.
  ///
  /// In tr, this message translates to:
  /// **'Artevo Çalma Listeleri'**
  String get artevoPlaylists;

  /// No description provided for @back.
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get back;

  /// No description provided for @bookmarks.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilenler'**
  String get bookmarks;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get cancel;

  /// No description provided for @clearAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Temizle'**
  String get clearAll;

  /// No description provided for @close.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get close;

  /// No description provided for @closePlayer.
  ///
  /// In tr, this message translates to:
  /// **'Oynatıcıyı Kapat'**
  String get closePlayer;

  /// No description provided for @contactText.
  ///
  /// In tr, this message translates to:
  /// **'Ayrıntılı bilgi almak, öneri ya da şikayette bulunmak,  telif hakı bildirimi yapmak, destekte bulunmak veya editör olmak isterseniz e-mail adresi ya da Discord üzerinden iletişime geçebilirsiniz.'**
  String get contactText;

  /// No description provided for @contactUs.
  ///
  /// In tr, this message translates to:
  /// **'İletişim'**
  String get contactUs;

  /// No description provided for @contentIsNotFound.
  ///
  /// In tr, this message translates to:
  /// **'İçerik Bulunamadı!'**
  String get contentIsNotFound;

  /// No description provided for @continuee.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get continuee;

  /// No description provided for @copyEmailInfo.
  ///
  /// In tr, this message translates to:
  /// **'E-Posta Adresi Kopyalandı!'**
  String get copyEmailInfo;

  /// No description provided for @couldNotOpenUrl.
  ///
  /// In tr, this message translates to:
  /// **'URL açılamadı!'**
  String get couldNotOpenUrl;

  /// No description provided for @cover.
  ///
  /// In tr, this message translates to:
  /// **'Kapak'**
  String get cover;

  /// No description provided for @create.
  ///
  /// In tr, this message translates to:
  /// **'Oluştur'**
  String get create;

  /// No description provided for @createPlaylist.
  ///
  /// In tr, this message translates to:
  /// **'Çalma Listesi Oluştur'**
  String get createPlaylist;

  /// No description provided for @darkTheme.
  ///
  /// In tr, this message translates to:
  /// **'Koyu Tema'**
  String get darkTheme;

  /// No description provided for @dataIsNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Veri bulunamadı!'**
  String get dataIsNotFound;

  /// No description provided for @delete.
  ///
  /// In tr, this message translates to:
  /// **'Sil!'**
  String get delete;

  /// No description provided for @discover.
  ///
  /// In tr, this message translates to:
  /// **'Keşfet'**
  String get discover;

  /// No description provided for @edit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get edit;

  /// No description provided for @err.
  ///
  /// In tr, this message translates to:
  /// **'Hata'**
  String get err;

  /// No description provided for @errConnection.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı Sorunu'**
  String get errConnection;

  /// No description provided for @errInternetConnection.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen internet bağlantınızı kontrol edin!'**
  String get errInternetConnection;

  /// No description provided for @errPaintingLoaded.
  ///
  /// In tr, this message translates to:
  /// **'Görsel yüklenemedi!'**
  String get errPaintingLoaded;

  /// No description provided for @errTimeSync.
  ///
  /// In tr, this message translates to:
  /// **'Cihazınızın tarihi ve saati güncel değil!'**
  String get errTimeSync;

  /// No description provided for @errUnknow.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen hata oluştu. Lütfen tekrar deneyin. Hata devam ederse lütfen bizimle iletişime geçin Mail: {mailAdress}'**
  String errUnknow(Object mailAdress);

  /// No description provided for @forceUpdateText.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamanın yeni bir sürümü mevcut. Devam etmek için güncellemeniz gerekmektedir.'**
  String get forceUpdateText;

  /// No description provided for @forceUpdateTitle.
  ///
  /// In tr, this message translates to:
  /// **'Artevo Güncel Değil'**
  String get forceUpdateTitle;

  /// No description provided for @goetheQuote.
  ///
  /// In tr, this message translates to:
  /// **'İnsan her gün bir parça müzik dinlemeli, İyi bir şiir okumalı, güzel bir tablo görmeli ve mümkünse birkaç mantıklı cümle söylemeli.'**
  String get goetheQuote;

  /// No description provided for @home.
  ///
  /// In tr, this message translates to:
  /// **'Anasayfa'**
  String get home;

  /// No description provided for @history.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş'**
  String get history;

  /// No description provided for @imageNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Görsel Bulunamadı!'**
  String get imageNotFound;

  /// No description provided for @langCode.
  ///
  /// In tr, this message translates to:
  /// **'tr'**
  String get langCode;

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @languageName.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageName;

  /// No description provided for @licenses.
  ///
  /// In tr, this message translates to:
  /// **'Lisanslar'**
  String get licenses;

  /// No description provided for @listenAgain.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dinle'**
  String get listenAgain;

  /// No description provided for @listeningHistory.
  ///
  /// In tr, this message translates to:
  /// **'Dinleme Geçmişi'**
  String get listeningHistory;

  /// No description provided for @more.
  ///
  /// In tr, this message translates to:
  /// **'daha fazla...'**
  String get more;

  /// No description provided for @music.
  ///
  /// In tr, this message translates to:
  /// **'Müzik'**
  String get music;

  /// No description provided for @musics.
  ///
  /// In tr, this message translates to:
  /// **'Müzikler'**
  String get musics;

  /// No description provided for @next.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki'**
  String get next;

  /// No description provided for @noPlaylistFound.
  ///
  /// In tr, this message translates to:
  /// **'Çalma listesi bulunamadı.\nŞimdi bir tane oluşturmak ister misin?'**
  String get noPlaylistFound;

  /// No description provided for @notificationDescriptionText.
  ///
  /// In tr, this message translates to:
  /// **'Günde bir kere, istediğin saatte.'**
  String get notificationDescriptionText;

  /// No description provided for @notificationPermissionText.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim özelliğinin açılması için ayarlardan izin vermeniz gerekmektedir.\n\nAyarlar > Artevo > Bildirimler'**
  String get notificationPermissionText;

  /// No description provided for @notificationTimeDescription.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlatıcı saat {hour}:{min} ayarlandı.'**
  String notificationTimeDescription(Object hour, Object min);

  /// No description provided for @notifications.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get notifications;

  /// No description provided for @other.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get other;

  /// No description provided for @painting.
  ///
  /// In tr, this message translates to:
  /// **'Tablo'**
  String get painting;

  /// No description provided for @paintings.
  ///
  /// In tr, this message translates to:
  /// **'Tablolar'**
  String get paintings;

  /// No description provided for @pause.
  ///
  /// In tr, this message translates to:
  /// **'Duraklat'**
  String get pause;

  /// No description provided for @play.
  ///
  /// In tr, this message translates to:
  /// **'Oynat'**
  String get play;

  /// No description provided for @playAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Oynat'**
  String get playAll;

  /// No description provided for @playlist.
  ///
  /// In tr, this message translates to:
  /// **'Çalma Listesi'**
  String get playlist;

  /// No description provided for @playlistName.
  ///
  /// In tr, this message translates to:
  /// **'Çalma Listesi Adı'**
  String get playlistName;

  /// No description provided for @playlists.
  ///
  /// In tr, this message translates to:
  /// **'Çalma Listeleri'**
  String get playlists;

  /// No description provided for @poem.
  ///
  /// In tr, this message translates to:
  /// **'Şiir'**
  String get poem;

  /// No description provided for @poems.
  ///
  /// In tr, this message translates to:
  /// **'Şiirler'**
  String get poems;

  /// No description provided for @pollQuestion.
  ///
  /// In tr, this message translates to:
  /// **'Bu seçkiler hoşunuza gitti mi?'**
  String get pollQuestion;

  /// No description provided for @previous.
  ///
  /// In tr, this message translates to:
  /// **'Önceki'**
  String get previous;

  /// No description provided for @privacyPolicy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası'**
  String get privacyPolicy;

  /// No description provided for @rateArtevo.
  ///
  /// In tr, this message translates to:
  /// **'Artevo\'yu Değerlendirin'**
  String get rateArtevo;

  /// No description provided for @refresh.
  ///
  /// In tr, this message translates to:
  /// **'Yenile'**
  String get refresh;

  /// No description provided for @removeBookmarks.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilenler\'den Kaldır'**
  String get removeBookmarks;

  /// No description provided for @removeFromPlaylist.
  ///
  /// In tr, this message translates to:
  /// **'Çalma Listesinden Kaldır'**
  String get removeFromPlaylist;

  /// No description provided for @search.
  ///
  /// In tr, this message translates to:
  /// **'Ara'**
  String get search;

  /// No description provided for @searchHistory.
  ///
  /// In tr, this message translates to:
  /// **'Arama Geçmişi'**
  String get searchHistory;

  /// No description provided for @searchResultFor.
  ///
  /// In tr, this message translates to:
  /// **'\'{text}\' için arama sonuçları:'**
  String searchResultFor(Object text);

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settings;

  /// No description provided for @showAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Göster'**
  String get showAll;

  /// No description provided for @submit.
  ///
  /// In tr, this message translates to:
  /// **'Gönder'**
  String get submit;

  /// No description provided for @submitFeedback.
  ///
  /// In tr, this message translates to:
  /// **'Geribildirim Gönder'**
  String get submitFeedback;

  /// No description provided for @success.
  ///
  /// In tr, this message translates to:
  /// **'Başarılı!'**
  String get success;

  /// No description provided for @termsOfUse.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları'**
  String get termsOfUse;

  /// No description provided for @termsOfUseToContinue.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamayı kullanmaya devam ettiğiniz takdirde \'Gizlilik Politikası\'nı ve \'Kullanım Koşulları\'nı kabul etmiş sayılırsınız.'**
  String get termsOfUseToContinue;

  /// No description provided for @thanks.
  ///
  /// In tr, this message translates to:
  /// **'Teşekkürler!'**
  String get thanks;

  /// No description provided for @thanksForYourFeedback.
  ///
  /// In tr, this message translates to:
  /// **'Geribildiriminiz için teşekkürler.'**
  String get thanksForYourFeedback;

  /// No description provided for @todayInArtevo.
  ///
  /// In tr, this message translates to:
  /// **'Artevo\'da Bugün'**
  String get todayInArtevo;

  /// No description provided for @visualArtworks.
  ///
  /// In tr, this message translates to:
  /// **'Görsel Sanat Eserleri'**
  String get visualArtworks;

  /// No description provided for @yourLibrary.
  ///
  /// In tr, this message translates to:
  /// **'Kitaplığın'**
  String get yourLibrary;

  /// No description provided for @welcome.
  ///
  /// In tr, this message translates to:
  /// **'Hoşgeldiniz'**
  String get welcome;
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
