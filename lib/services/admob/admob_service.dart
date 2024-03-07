import 'dart:io';
import 'dart:async';
import 'package:artevo/artevo_app.dart';
import 'package:artevo/common/enums/app_mode.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static Future<InterstitialAd?> loadInterstitialAd() async {
    String? adUnitId = AdUnits.interstitialAdUnitId;

    if (adUnitId == null) return null;

    Completer<InterstitialAd?> completer = Completer();

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
              completer.complete(ad);
            },
            onAdFailedToLoad: (LoadAdError e) => completer.completeError(e)));
    return completer.future;
  }
}

//  AdMob Test App Units
/* // ------ iOS
           App ID: ca-app-pub-3940256099942544~1458002511
        Banner ID: ca-app-pub-3940256099942544/2934735716 
  Interstitial ID: ca-app-pub-3940256099942544/4411468910 
 */
class AdUnits {
  /// home screen interstitial
  static String? get interstitialAdUnitId {
    if (Platform.isIOS) {
      return appmode == AppMode.debug
          ? "ca-app-pub-3940256099942544/4411468910" // ! TEST
          : "ca-app-pub-4083839786740154/2159070535"; // ! RELEASE
    } else if (Platform.isAndroid) {
      return appmode == AppMode.debug
          ? "ca-app-pub-3940256099942544/1033173712" // ! TEST
          : "ca-app-pub-4083839786740154/6366132561"; // ! RELEASE
    } else {
      return null;
    }
  }
}
