import 'package:artevo/screens/home/home_screen.dart';
import 'package:artevo/features/painting/views/painting_detail_view.dart';
import 'package:artevo/screens/setting/setting_screen.dart';
import 'package:artevo/screens/splash/splash_screen.dart';
import 'package:artevo/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

enum Screens { welcome, splash, home, settings, paintingDetail }

extension ScreenExtension on Screens {
  Widget _screen() {
    switch (this) {
      case Screens.welcome:
        return const WelcomeScreen();
      case Screens.splash:
        return const SplashScreen();
      case Screens.home:
        return const HomeScreen();
      case Screens.settings:
        return const SettingScreen();
      case Screens.paintingDetail:
        return const PaintingDetailScreen();
    }
  }

  String get routeName => "/$name";
}

class Routes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      Widget screen = Screens.values
          .byName((settings.name ?? Screens.splash.routeName).substring(1))
          ._screen();

      return MaterialPageRoute(builder: (_) => screen);
    } catch (e) {
      return MaterialPageRoute(builder: (_) => Screens.splash._screen());
    }
  }
}
