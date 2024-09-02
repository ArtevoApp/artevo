import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../../features/music/widgets/music_player.dart';
import 'nav_bar_controller.dart';
import 'screens_enum.dart';
import 'screens_extension.dart';

class MainLayoutScreen extends StatelessWidget {
  MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavBarController.instance.init();

    final maxHeight =
        MediaQuery.paddingOf(context).bottom + kBottomNavigationBarHeight;

    return PersistentTabView(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      tabs: List.generate(
        Screens.values.length,
        (index) => Screens.values[index].toBottomNavigationBarItem(context),
      ),
      navBarOverlap: const NavBarOverlap.none(),
      navBarBuilder: (navBarConfig) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MusicPlayer(),
          bottomNavBar(navBarConfig, maxHeight),
        ],
      ),
    );
  }

  AnimatedBuilder bottomNavBar(NavBarConfig navBarConfig, double maxHeight) {
    return AnimatedBuilder(
      animation: NavBarController.instance,
      builder: (context, child) {
        final height =
            !NavBarController.instance.isShowNavBar ? 0.0 : maxHeight;

        return AnimatedContainer(
          height: height,
          duration: const Duration(milliseconds: 300),
          child: Style2BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: NavBarDecoration(
                color: Theme.of(context).scaffoldBackgroundColor),
          ),
        );
      },
    );
  }
}
