import 'package:artevo/screens/home/home_screen.dart';
import 'package:artevo/features/painting/views/painting_detail_view.dart';
import 'package:artevo/screens/splash/splash_screen.dart';
import 'package:artevo/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

const String splashRoute = "/";
const String homeRoute = "/homeRoute";
const String welcomeRoute = "/welcomeRoute";
const String settingsRoute = "/settingsRoute";
const String paintingDetailRoute = "/paintingDetailRoute";

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case paintingDetailRoute:
        return MaterialPageRoute(builder: (_) => const PaintingDetailScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text("Error 404: Page not found"),
            ),
          ),
        );
    }
  }
}
