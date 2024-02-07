import 'package:artevo/features/home/home_screen.dart';
import 'package:artevo/features/painting/painting_detail_screen.dart';
import 'package:artevo/features/setting/setting_screen.dart';
import 'package:artevo/features/splash/splash_screen.dart';
import 'package:artevo/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

enum Screens { welcome, splash, home, settings, paintingDetail }

extension PagesExtension on Screens {
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

  Route goScreen() => MaterialPageRoute(builder: (_) => _screen());
}

class Routes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      return Screens.values
          .byName((settings.name ?? "/welcome").substring(1))
          .goScreen();
    } catch (e) {
      return Screens.welcome.goScreen(); // i.e Home Screen
    }
  }
}
