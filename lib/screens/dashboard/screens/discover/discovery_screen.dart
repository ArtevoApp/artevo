import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/constants/dimens.dart';
import '../../../../features/music/screens/music_discovery_screen.dart';
import '../../../../features/painting/screens/paintings_discovery_screen.dart';

import '../../../../localization/app_localizations_context.dart';
import '../../layout/main_layout_controller.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen>
    with TickerProviderStateMixin {
  // The controller of the [TabBar] in the [DiscoveryScreen].
  late final TabController tabController;
  // The controller of the [NestedScrollView] in the [DiscoveryScreen].
  final scrollController = ScrollController();
  // The controller of the [MainLayoutController].
  final layoutController = MainLayoutController.instance;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(() => layoutController
        .autoUpdateNavBarView(scrollController.position.userScrollDirection));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: scrollController,
      restorationId: 'discovery_screen_nested_scroll_view',
      headerSliverBuilder: (_, __) => [tabbar()],
      body: TabBarView(
        controller: tabController,
        children: const [
          PaintingsDiscoveryScreen(),
          MusicDiscoveryScreen(),
        ],
      ),
    );
  }

  Widget tabbar() {
    return SliverAppBar(
      pinned: false,
      centerTitle: true,
      title: TabBar(
        controller: tabController,
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
