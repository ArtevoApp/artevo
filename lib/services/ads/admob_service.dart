import 'dart:io';
import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../common/enums/app_mode.dart';
import '../../common/global_variables/global_app_mode.dart';

class AdmobService {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static InterstitialAd? interstitialAd;

  static Future<bool> loadInterstitialAd() async {
    final String? adUnitId = AdUnits.interstitialAdUnitId;

    if (adUnitId == null) return false;

    try {
      final Completer<InterstitialAd?> completer = Completer();

      InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) => ad.dispose(),
                onAdDismissedFullScreenContent: (ad) => ad.dispose(),
                onAdClicked: (ad) {},
              );
              interstitialAd = ad;

              completer.complete(ad);
            },
            onAdFailedToLoad: completer.completeError),
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}

class AdUnits {
  /// home screen interstitial
  static String? get interstitialAdUnitId {
    if (Platform.isIOS) {
      return appMode == AppMode.debug
          ? "ca-app-pub-3940256099942544/4411468910" // ! TEST
          : "ca-app-pub-4083839786740154/2159070535"; // ! RELEASE
    } else if (Platform.isAndroid) {
      return appMode == AppMode.debug
          ? "ca-app-pub-3940256099942544/1033173712" // ! TEST
          : "ca-app-pub-4083839786740154/6366132561"; // ! RELEASE
    } else {
      return null;
    }
  }
}

//  AdMob Test App Units
/* // ------ iOS
           App ID: ca-app-pub-3940256099942544~1458002511
        Banner ID: ca-app-pub-3940256099942544/2934735716 
  Interstitial ID: ca-app-pub-3940256099942544/4411468910 
 */