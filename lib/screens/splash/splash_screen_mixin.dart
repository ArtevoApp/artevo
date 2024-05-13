part of "splash_screen.dart";

mixin SplashScreenMixin on State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    /// user first login check
    final bool isFirstLogin = UserDataManager.instance.getFirstLoginStatus;

    /// if first login go to welcome screen
    if (isFirstLogin) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(
            context, welcomeRoute, (route) => false);
      });
    }

    /// else check other controls
    else {
      final dataManager = DataManager.instance;
      final paintingsRepo = PaintingRepository.instance;

      final Future<bool> versionControl = dataManager.checkAppVersionData;

      final Future<bool> localContent = paintingsRepo.checkSavedPaintingData;

      final Future<bool> interstitial = AdmobService.loadInterstitialAd();

      final Future<bool> delay =
          Future.delayed(const Duration(seconds: 3)).then((value) => true);

      await Future.wait<bool>(
              [versionControl, localContent, interstitial, delay])
          .then((controls) async {
        // version control
        // if version is old show force update dialog and not go to home.
        if (!controls[0]) {
          await ForceUpdateAlertDialog.show(context);
        } else {
          // artevo dailyContent and saved content control
          if (!controls[2]) {
            // if content data is not found show error dialog and not go to home.
            ErrorDialog.show(context);
          } else {
            // if version is up to date and the content is found:
            // go to home screen and show the interstitial.
            Navigator.pushNamedAndRemoveUntil(
                context, mainRoute, (route) => false);

            // interstitial data control
            if (controls[3] && AdmobService.interstitialAd != null) {
              AdmobService.interstitialAd!.show();
            }
          }
        }
      });
    }
  }
}
