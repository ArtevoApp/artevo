import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/screens/home/views/bookmark_view.dart';
import 'package:artevo/screens/home/views/home_view.dart';
import 'package:artevo/screens/home/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

enum HomeScreenView { home, bookmarks, settings }

extension HomeScreenViewExtension on HomeScreenView {
  SalomonBottomBarItem toBottomNavigationBarItem(BuildContext _) {
    switch (this) {
      case HomeScreenView.home:
        return SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text(_.loc.home),
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
      case HomeScreenView.bookmarks:
        return const BookmarkView();
      case HomeScreenView.settings:
        return const SettingView();
    }
  }
}
