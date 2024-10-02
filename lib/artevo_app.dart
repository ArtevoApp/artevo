import 'common/global_variables/language.dart';
import 'common/global_variables/theme_mode.dart';
import 'common/global_variables/app_mode.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/config/color_schemes.dart';
import 'core/config/routes.dart';
import 'common/constants/fonts.dart';
import 'common/constants/strings.dart';
import 'common/enums/app_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArtevoApp extends StatelessWidget {
  const ArtevoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeModeController,
      builder: (context, themeMode, child) {
        return ValueListenableBuilder(
          valueListenable: localeController,
          builder: (context, locale, child) {
            return AnnotatedRegion(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Colors.transparent,
              ),
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
                  useMaterial3: true,
                  fontFamily: Fonts.montserrat,
                  colorScheme: lightColorScheme,
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  fontFamily: Fonts.montserrat,
                  colorScheme: darkColorScheme,
                ),
                // routes
                initialRoute: splashRoute,
                onGenerateRoute: Routes.generateRoute,
              ),
            );
          },
        );
      },
    );
  }
}
