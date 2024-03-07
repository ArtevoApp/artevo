import 'package:artevo/common/config/color_schemes.dart';
import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/fonts.dart';
import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/common/enums/app_mode.dart';
import 'package:artevo/common/widgets/language_selection_widgets.dart';
import 'package:artevo/common/widgets/theme_toggle_button.dart';
import 'package:artevo/global_veriables.dart';
import 'package:artevo/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtevoApp extends StatelessWidget {
  const ArtevoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ThemeMode themeMode = ref.watch(themeModeProvider);

      Locale? locale = ref.watch(selectedLanguageProvider);

      return MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: appmode == AppMode.debug,

        // localizations
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,

        // theme settings
        themeMode: themeMode,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: Fonts.domine,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          fontFamily: Fonts.domine,
        ),

        // routes
        initialRoute: splashRoute,
        onGenerateRoute: Routes.generateRoute,
      );
    });
  }
}
