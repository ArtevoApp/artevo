part of "splash_screen.dart";

mixin SplashScreenMixin on State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    /// user first login check
    bool isFirstLogin = HiveUserDataService.instance.getFirstLoginStatus;

    /// if first login go to welcome screen
    if (isFirstLogin) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(
            context, Screens.welcome.routeName, (route) => false);
      });
    }

    /// else check version
    else {
      Future<bool> versionControl = ServiceManger().checkAppVersionData();

      Future<bool> contentControl = ServiceManger().checkContentData();

      Future<InterstitialAd?> interstitial = Admob.loadInterstitialAd();

      Future delay = Future.delayed(const Duration(seconds: 3));

      await Future.wait([versionControl, contentControl, interstitial, delay])
          .then((controls) {
        // version control
        if (!controls[0]) {
          // if version is old show force update dialog
          ForceUpdateAlertDialog.show(context);
        } else {
          // artevo content control
          if (!controls[1]) {
            // if content data is not found show error dialog and not go to home
            ErrorDialog.show(context);
          } else {
            // if version is up to date and the content is found:
            // go to home screen and show the interstitial.
            Navigator.pushNamedAndRemoveUntil(
                context, Screens.home.routeName, (route) => false);

            // interstitial data control
            if (controls[2] != null) (controls[2] as InterstitialAd).show();
          }
        }
      });
    }
  }
}
