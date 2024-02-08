part of "splash_screen.dart";

mixin SplashScreenMixin on State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    bool isFirstLogin = HiveUserDataService().getFirstLoginStatus;
    if (isFirstLogin) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(
            context, Screens.welcome.routeName, (route) => false);
      });
    } else {
      Future<bool> versionControl = ServiceManger().checkAppVersionData();
      Future<bool> contentControl = ServiceManger().checkContentData();

      Future delay = Future.delayed(const Duration(seconds: 3));

      await Future.wait([versionControl, contentControl, delay])
          .then((controls) {
        // version control
        if (controls[0]) {
          // content data control
          if (controls[1]) {
            Navigator.pushNamedAndRemoveUntil(
                context, Screens.home.routeName, (route) => false);
          } else {
            ErrorDialog.show(context);
          }
        } else {
          ForceUpdateAlertDialog.show(context);
        }
      });
    }
  }
}
