import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../localization/app_localizations_context.dart';
import '../bookmarks/bookmarks_screen.dart';
import '../discover/discovery_screen.dart';
import '../home/home_screen.dart';
import '../settings/settings_screen.dart';
import 'screens_enum.dart';

extension ScreensExtension on Screens {
  PersistentTabConfig toBottomNavigationBarItem(BuildContext _) {
    switch (this) {
      case Screens.home:
        return PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: const Icon(Iconsax.home_2),
            title: _.loc.home,
            activeForegroundColor: Theme.of(_).colorScheme.tertiary,
          ),
        );

      case Screens.discover:
        return PersistentTabConfig(
          screen: const DiscoveryScreen(),
          item: ItemConfig(
            icon: const Icon(Iconsax.discover),
            title: _.loc.discover,
            activeForegroundColor: Theme.of(_).colorScheme.tertiary,
          ),
        );
      case Screens.bookmarks:
        return PersistentTabConfig(
          screen: const BookmarksScreen(),
          item: ItemConfig(
            icon: const Icon(Iconsax.bookmark),
            title: _.loc.bookmarks,
            activeForegroundColor: Theme.of(_).colorScheme.tertiary,
          ),
        );
      case Screens.settings:
        return PersistentTabConfig(
          screen: const SettingsScreen(),
          item: ItemConfig(
            icon: const Icon(Iconsax.setting_2),
            title: _.loc.settings,
            activeForegroundColor: Theme.of(_).colorScheme.tertiary,
          ),
        );
    }
  }
}
