import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../layout/main_layout_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../localization/app_localizations_context.dart';

class IBottomNavBar extends StatelessWidget {
  const IBottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    final layoutController = MainLayoutController.instance;
    final maxHeight =
        MediaQuery.paddingOf(context).bottom + kBottomNavigationBarHeight;
    return AnimatedBuilder(
      animation: layoutController.navBarController,
      builder: (context, child) {
        final height =
            !layoutController.navBarController.value ? 0.0 : maxHeight;
        final colorScheme = Theme.of(context).colorScheme;
        return AnimatedContainer(
          height: height,
          duration: const Duration(milliseconds: 300),
          child: ValueListenableBuilder(
            valueListenable: layoutController.currentIndex,
            builder: (context, currentIndex, child) {
              return SalomonBottomBar(
                currentIndex: currentIndex,
                onTap: layoutController.updateCurrentIndex,
                selectedItemColor: colorScheme.primary,
                unselectedItemColor: colorScheme.secondary,
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Iconsax.home),
                    title: Text(context.loc.home),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Iconsax.discover),
                    title: Text(context.loc.discover),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Iconsax.bookmark),
                    title: Text(context.loc.bookmarks),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Iconsax.setting_2),
                    title: Text(context.loc.settings),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
