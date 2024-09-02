import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/constants/dimens.dart';
import '../../common/constants/text_styles.dart';
import '../../features/music/screens/music_discovery_screen.dart';
import '../../features/painting/screens/paintings_discovery_screen.dart';

import '../../localization/app_localizations_context.dart';
import '../_main/nav_bar_controller.dart';
import 'discovery_screen_variables.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: discoveryScreenTabIndex,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        restorationId: 'discovery_screen_nested_scroll_view',
        controller: NavBarController.instance.discoverScrollController,
        headerSliverBuilder: (_, __) => [tabbar(_)],
        body: const TabBarView(
          children: [PaintingsDiscoveryScreen(), MusicDiscoveryScreen()],
        ),
      ),
    );
  }

  SliverAppBar tabbar(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      centerTitle: true,
      title: Text(context.loc.discover, style: TextStyles.pageTitle),
      bottom: TabBar(
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.brush_1),
                const SizedBox(width: defaultPadding),
                Text(context.loc.paintings),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.music_dashboard),
                const SizedBox(width: defaultPadding),
                Text(context.loc.musics),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
