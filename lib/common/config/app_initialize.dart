import 'package:artevo/services/admob/admob_service.dart';
import 'package:artevo/services/notification/notification_service.dart';
import 'package:artevo/firebase_options.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AppInitialize {
  const AppInitialize._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // firebase service
    await Firebase.initializeApp(
        options: MobileAppFirebaseOptions.currentPlatform);

    // admob for ads
    await Admob.initialize();

    // hive boxes
    await Hive.initFlutter();
    await Hive.openBox('userDataBox');
    await Hive.openBox('contentDataBox');

    // notification service
    if (HiveUserDataService().getNotificationSendingStatus) {
      NotificationsService.init();
    }

    // font lisans dosyasının kayıt edilmesi
    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/license/domine_ofl.txt');

      yield LicenseEntryWithLineBreaks(['Domine OFL'], license);
    });

    // audio
    await JustAudioBackground.init(
        androidNotificationChannelId: 'com.opifer.artevo.channel.audio',
        androidNotificationChannelName: 'Artevo Music',
        androidNotificationOngoing: true);

    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
  }
}
