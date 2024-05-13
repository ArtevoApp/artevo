import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

import '../../features/music/service/audio_player_handler.dart';
import '../../services/ads/admob_service.dart';
import '../../services/cache/lazy_user_data_manager.dart';
import '../../services/database/firebase/firebase_options.dart';
import '../../services/database/local/local_data_service.dart';
import '../../services/notification/notification_service.dart';
import '../constants/fonts.dart';
import '../global_variables/global_audio_handler.dart';
import '../../services/cache/daily_content_data_manager.dart';
import '../../services/cache/user_data_manager.dart';

class AppInitialize {
  const AppInitialize._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // firebase service
    await Firebase.initializeApp(
        options: MobileAppFirebaseOptions.currentPlatform);

    // admob service
    await AdmobService.initialize();

    // hive boxes
    await Hive.initFlutter();
    await UserDataManager.instance.init();
    await LazyUserDataManager.instance.init();
    await DailyContentDataManager.instance.init();

    // local database
    await LocalDataService.instance.init();

    // notification service.
    if (UserDataManager.instance.getNotificationSendingStatus) {
      NotificationsService.init();
    }

    // Saving the font license file.
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString(Fonts.domineLicencePath);

      yield LicenseEntryWithLineBreaks(['Domine OFL'], license);
    });

    // Music service
    audioHandler = await AudioService.init(
      builder: AudioPlayerHandlerImpl.new,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.opifer.artevo.channel.audio',
        androidNotificationChannelName: 'Artevo Music',
        androidNotificationOngoing: true,
        androidShowNotificationBadge: true,
      ),
    );

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
