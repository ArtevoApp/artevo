import 'common/config/routes.dart';
import 'common/config/theme.dart';
import 'common/constants/fonts.dart';
import 'common/constants/strings.dart';
import 'common/enums/app_mode.dart';
import 'common/global_variables/global_app_mode.dart';
import 'common/widgets/language_selection_widgets.dart';
import 'common/widgets/theme_toggle_button.dart';
import 'localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtevoApp extends StatelessWidget {
  const ArtevoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final ThemeMode themeMode = ref.watch(themeModeProvider);

      final Locale? locale = ref.watch(selectedLanguageProvider);

      return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent),
        child: MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: appMode == AppMode.debug,

          // localizations
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          // theme settings
          themeMode: themeMode,
          theme: ThemeData(
            colorScheme: MaterialTheme.lightScheme().toColorScheme(),
            fontFamily: Fonts.domine,
          ),
          darkTheme: ThemeData(
            colorScheme: MaterialTheme.darkScheme().toColorScheme(),
            fontFamily: Fonts.domine,
          ),
          highContrastTheme: ThemeData(
            colorScheme:
                MaterialTheme.lightHighContrastScheme().toColorScheme(),
            fontFamily: Fonts.domine,
          ),
          highContrastDarkTheme: ThemeData(
            colorScheme: MaterialTheme.darkHighContrastScheme().toColorScheme(),
            fontFamily: Fonts.domine,
          ),

          // routes
          initialRoute: splashRoute,
          onGenerateRoute: Routes.generateRoute,
        ),
      );
    });
  }
}
