import 'package:flutter/material.dart';
import '../../../../common/constants/dimens.dart';
import '../../../../common/constants/text_styles.dart';
import '../../../../features/music/screens/music_discovery_screen.dart';
import '../../../../features/painting/screens/paintings_discovery_screen.dart';
import '../../../../core/localization/app_localizations_context.dart';
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
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => NestedScrollView(
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
        ),
      ),
    );
  }

  Widget tabbar() {
    return SliverAppBar(
      pinned: false,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
            width: .2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        padding: EdgeInsets.zero,
        child: TabBar(
          controller: tabController,
          padding: EdgeInsets.zero,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Theme.of(context).colorScheme.surface,
          unselectedLabelColor: Theme.of(context).colorScheme.secondary,
          indicatorPadding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: smallPadding,
          ),
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          tabs: [
            Tab(
              height: 38,
              child: Text(context.loc.paintings, style: TextStyles.b1),
            ),
            Tab(
              height: 38,
              child: Text(context.loc.musics, style: TextStyles.b1),
            ),
          ],
        ),
      ),
    );
  }
}
