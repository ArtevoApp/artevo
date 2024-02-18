import 'dart:io';
import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:artevo/main.dart';
import 'package:artevo/common/enums/app_mode.dart';

class Admob {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static Future<InterstitialAd?> loadInterstitialAd() async {
    Completer<InterstitialAd?> completer = Completer();

    InterstitialAd.load(
        adUnitId: AdUnits.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                onAdClicked: (ad) {});

            completer.complete(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            completer.completeError(error);
          },
        ));

    return completer.future;
  }
}

//  AdMob Test App Units
/* // ------ iOS ---------------------------------------------------------------

           App ID: ca-app-pub-3940256099942544~1458002511  //
        Banner ID: ca-app-pub-3940256099942544/2934735716  // banner 
  Interstitial ID: ca-app-pub-3940256099942544/4411468910  // geçiş reklamı
 
*/ //  -------------------------------------------------------------------------

class AdUnits {
  //* ------------------------------------------------------------------------- */
  //*                      home page interstitial                               */
  //* ------------------------------------------------------------------------- */

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return appmode == AppMode.debug
          ? "ca-app-pub-3940256099942544/1033173712" // ! TEST
          : "ca-app-pub-2779170244273114/9374533384"; // ! RELEASE // TODO
    } else if (Platform.isIOS) {
      return appmode == AppMode.debug
          ? "ca-app-pub-3940256099942544/4411468910" // ! TEST
          : "ca-app-pub-4083839786740154/2159070535"; // ! RELEASE
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
