import 'app_localizations.dart';

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get addAComment => 'Bir yorum ekleyin...';

  @override
  String get appPurpose => 'Artevo, sizleri her gün bir sanat eseri, bir şiir ve bir şarkı ile buluşturarak hayatınıza estetik bir dokunuş katmayı amaçlar.';

  @override
  String get appPurposev2 => 'Artevo, sanat ve estetik tutkunları için tasarlanmıştır. Sizleri her gün bir sanat eseri, bir şiir ve bir şarkı ile buluşturarak hayatınıza estetik bir dokunuş katmayı amaçlar.';

  @override
  String get artevoContentOfTheDay => 'Artevo Günün İçeriği';

  @override
  String get artevoReminder => 'Artevo Hatırlatıcı';

  @override
  String get back => 'Geri';

  @override
  String get cancel => 'İptal';

  @override
  String get contactText => 'Ayrıntılı bilgi almak, öneri ya da şikayette bulunmak,  telif hakı bildirimi yapmak, destekte bulunmak veya editör olmak isterseniz e-mail adresi ya da Discord üzerinden iletişime geçebilirsiniz.';

  @override
  String get contactUs => 'İletişim';

  @override
  String get contentIsNotFound => 'İçerik Bulunamadı!';

  @override
  String get continuee => 'Devam Et';

  @override
  String get copyEmailInfo => 'E-Posta Adresi Kopyalandı!';

  @override
  String get couldNotOpenUrl => 'URL açılamadı!';

  @override
  String get darkTheme => 'Koyu Tema';

  @override
  String get edit => 'Düzenle';

  @override
  String get error => 'Hata';

  @override
  String get errorPaintingLoaded => 'Görsel yüklenemedi!';

  @override
  String get forceUpdateText => 'Uygulamanın yeni bir sürümü mevcut. Devam etmek için güncellemeniz gerekmektedir.';

  @override
  String get forceUpdateTitle => 'Artevo Güncel Değil';

  @override
  String get goetheQuote => 'İnsan her gün bir parça müzik dinlemeli, İyi bir şiir okumalı, güzel bir tablo görmeli ve mümkünse birkaç mantıklı cümle söylemeli.';

  @override
  String get imageNotFound => 'Görsel Bulunamadı!';

  @override
  String get langCode => 'tr';

  @override
  String get language => 'Dil';

  @override
  String get languageName => 'Türkçe';

  @override
  String get licenses => 'Lisanslar';

  @override
  String get more => 'daha fazla...';

  @override
  String get notificationDescriptionText => 'Günde bir kere, istediğin saatte.';

  @override
  String get notificationPermissionText => 'Bildirim özelliğinin açılması için ayarlardan izin vermeniz gerekmektedir.\n\nAyarlar > Artevo > Bildirimler';

  @override
  String notificationTimeDescription(Object hour, Object min) {
    return 'Hatırlatıcı saat $hour:$min ayarlandı.';
  }

  @override
  String get notifications => 'Bildirimler';

  @override
  String get other => 'Diğer';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get rateArtevo => 'Artevo\'yu Değerlendirin';

  @override
  String get settings => 'Ayarlar';

  @override
  String get submit => 'Gönder';

  @override
  String get submitFeedback => 'Geribildirim Gönder';

  @override
  String get termsOfUse => 'Kullanım Koşulları';

  @override
  String get termsOfUseToContinue => 'Uygulamayı kullanmaya devam ettiğiniz takdirde \'Gizlilik Politikası\'nı ve \'Kullanım Koşulları\'nı kabul etmiş sayılırsınız.';

  @override
  String get thanks => 'Teşekkürler!';

  @override
  String get thanksForYourFeedback => 'Geribildiriminiz için teşekkürler.';

  @override
  String unknowErrorText(Object mailAdress) {
    return 'Bilinmeyen hata oluştu. Lütfen tekrar deneyin. Hata devam ederse lütfen bizimle iletişime geçin Mail: $mailAdress';
  }

  @override
  String get welcome => 'Hoşgeldiniz';

  @override
  String get wouldYouRateTodaysContent => 'Bugünkü içeriği değerlendirir misiniz?';
}
