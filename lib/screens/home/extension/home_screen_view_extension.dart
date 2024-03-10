import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/screens/home/views/bookmark_view.dart';
import 'package:artevo/screens/home/views/discover_view.dart';
import 'package:artevo/screens/home/views/home_view.dart';
import 'package:artevo/screens/home/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

enum HomeScreenView { home, discover, bookmarks, settings }

extension HomeScreenViewExtension on HomeScreenView {
  SalomonBottomBarItem toBottomNavigationBarItem(BuildContext _) {
    switch (this) {
      case HomeScreenView.home:
        return SalomonBottomBarItem(
          icon: Icon(Iconsax.home_2),
          title: Text("Artevo"), // contex.loc.home,
          selectedColor: Colors.purple,
        );
      case HomeScreenView.discover:
        return SalomonBottomBarItem(
          icon: Icon(Iconsax.discover),
          title: Text(_.loc.discover),
          selectedColor: Colors.purple,
        );
      case HomeScreenView.bookmarks:
        return SalomonBottomBarItem(
          icon: Icon(Iconsax.bookmark),
          title: Text(_.loc.library),
          selectedColor: Colors.purple,
        );
      case HomeScreenView.settings:
        return SalomonBottomBarItem(
          icon: Icon(Iconsax.setting_2),
          title: Text(_.loc.settings),
          selectedColor: Colors.purple,
        );
    }
  }

  Widget view() {
    switch (this) {
      case HomeScreenView.home:
        return const HomeView();
      case HomeScreenView.discover:
        return const DiscoverView();
      case HomeScreenView.bookmarks:
        return const BookmarkView();
      case HomeScreenView.settings:
        return const SettingView();
    }
  }
}
