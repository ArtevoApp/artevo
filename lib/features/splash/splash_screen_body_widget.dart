import 'package:artevo/common/constants/app_constants.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreenBodyWidget extends StatelessWidget {
  const SplashScreenBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text(appName, style: TextStyle(fontSize: 48)),
          const Text(appAuthor, style: TextStyle(fontSize: 12)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(
              context.loc.goetheQuote,
              style: const TextStyle(
                  fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Johann Wolfgang von Goethe", // —
              style: TextStyle(fontFamily: "Chomsky", fontSize: 26),
            ),
          ),
          const Spacer(flex: 2),
          SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary)),
          const Spacer()
        ],
      ).animate().fade(duration: const Duration(seconds: 2)),
    );
  }
}
