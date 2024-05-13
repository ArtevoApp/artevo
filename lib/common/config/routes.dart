import '../../screens/_main/main_layout_screen.dart';
import '../../features/painting/screens/painting_detail_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

const String splashRoute = "/";
const String mainRoute = "/mainRoute";
const String welcomeRoute = "/welcomeRoute";
const String settingsRoute = "/settingsRoute";
const String paintingDetailRoute = "/paintingDetailRoute";

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MainLayoutScreen());
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
