import 'app_localizations.dart';

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get addAComment => 'Bir yorum ekleyin...';

  @override
  String get addBookmarks => 'Kaydedilenler\'e Ekle';

  @override
  String get addQueue => 'Kuyruğa Ekle';

  @override
  String get addToPlaylist => 'Çalma Listesine Ekle';

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
  String get bookmarks => 'Kaydedilenler';

  @override
  String get cancel => 'İptal';

  @override
  String get close => 'Kapat';

  @override
  String get closePlayer => 'Oynatıcıyı Kapat';

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
  String get cover => 'Kapak';

  @override
  String get create => 'Oluştur';

  @override
  String get createPlaylist => 'Çalma Listesi Oluştur';

  @override
  String get darkTheme => 'Koyu Tema';

  @override
  String get dataIsNotFound => 'Veri bulunamadı!';

  @override
  String get delete => 'Sil!';

  @override
  String get discover => 'Keşfet';

  @override
  String get edit => 'Düzenle';

  @override
  String get err => 'Hata';

  @override
  String get errConnection => 'Bağlantı Sorunu';

  @override
  String get errInternetConnection => 'Lütfen internet bağlantınızı kontrol edin!';

  @override
  String get errPaintingLoaded => 'Görsel yüklenemedi!';

  @override
  String get errTimeSync => 'Cihazınızın tarihi ve saati güncel değil!';

  @override
  String errUnknow(Object mailAdress) {
    return 'Bilinmeyen hata oluştu. Lütfen tekrar deneyin. Hata devam ederse lütfen bizimle iletişime geçin Mail: $mailAdress';
  }

  @override
  String get forceUpdateText => 'Uygulamanın yeni bir sürümü mevcut. Devam etmek için güncellemeniz gerekmektedir.';

  @override
  String get forceUpdateTitle => 'Artevo Güncel Değil';

  @override
  String get goetheQuote => 'İnsan her gün bir parça müzik dinlemeli, İyi bir şiir okumalı, güzel bir tablo görmeli ve mümkünse birkaç mantıklı cümle söylemeli.';

  @override
  String get home => 'Ana Sayfa';

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
  String get listenAgain => 'Tekrar Dinle';

  @override
  String get more => 'daha fazla...';

  @override
  String get music => 'Müzik';

  @override
  String get musics => 'Müzikler';

  @override
  String get next => 'Sonraki';

  @override
  String get noPlaylistFound => 'Çalma listesi bulunamadı.\nŞimdi bir tane oluşturmak ister misin?';

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
  String get painting => 'Tablo';

  @override
  String get paintings => 'Tablolar';

  @override
  String get pause => 'Duraklat';

  @override
  String get play => 'Oynat';

  @override
  String get playAll => 'Tümünü Oynat';

  @override
  String get playlist => 'Çalma Listesi';

  @override
  String get playlistName => 'Çalma Listesi Adı';

  @override
  String get playlists => 'Çalma Listeleri';

  @override
  String get poem => 'Şiir';

  @override
  String get poems => 'Şiirler';

  @override
  String get pollQuestion => 'Bu seçkiler hoşunuza gitti mi?';

  @override
  String get previous => 'Önceki';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get rateArtevo => 'Artevo\'yu Değerlendirin';

  @override
  String get refresh => 'Yenile';

  @override
  String get removeBookmarks => 'Kaydedilenler\'den Kaldır';

  @override
  String get removeFromPlaylist => 'Çalma Listesinden Kaldır';

  @override
  String get search => 'Ara';

  @override
  String get searchHistory => 'Arama Geçmişi';

  @override
  String searchResultFor(Object text) {
    return '\'$text\' için arama sonuçları:';
  }

  @override
  String get settings => 'Ayarlar';

  @override
  String get showAll => 'Tümünü Göster';

  @override
  String get submit => 'Gönder';

  @override
  String get submitFeedback => 'Geribildirim Gönder';

  @override
  String get success => 'Başarılı!';

  @override
  String get termsOfUse => 'Kullanım Koşulları';

  @override
  String get termsOfUseToContinue => 'Uygulamayı kullanmaya devam ettiğiniz takdirde \'Gizlilik Politikası\'nı ve \'Kullanım Koşulları\'nı kabul etmiş sayılırsınız.';

  @override
  String get thanks => 'Teşekkürler!';

  @override
  String get thanksForYourFeedback => 'Geribildiriminiz için teşekkürler.';

  @override
  String get todayInArtevo => 'Artevo\'da Bugün';

  @override
  String get visualArtworks => 'Görsel Sanat Eserleri';

  @override
  String get welcome => 'Hoşgeldiniz';
}
