import 'main_layout_controller.dart';
import 'package:flutter/material.dart';
import '../../../features/music/widgets/music_player.dart';
import '../screens/bookmarks/bookmarks_screen.dart';
import '../screens/discover/discovery_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainLayoutScreen extends StatefulWidget {
  MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder(
            valueListenable: MainLayoutController.instance.currentIndex,
            builder: (context, currentIndex, child) {
              return IndexedStack(
                index: currentIndex,
                children: const [
                  HomeScreen(),
                  DiscoveryScreen(),
                  BookmarksScreen(),
                  SettingsScreen(),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MusicPlayer(),
          IBottomNavBar(),
        ],
      ),
    );
  }
}
