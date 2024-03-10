import 'package:artevo/features/music/view/widgets/mini_music_player.dart';
import 'package:artevo/screens/home/controllers/view_controller.dart';
import 'package:artevo/screens/home/extension/home_screen_view_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    int currentIndex = ref.watch(homeViewController);

    List<HomeScreenView> views = HomeScreenView.values;

    return Scaffold(
      body: views.elementAt(currentIndex).view(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MiniMusicPlayer(),
          SalomonBottomBar(
            currentIndex: currentIndex,
            onTap: (i) => ref.read(homeViewController.notifier).state = i,
            items:
                views.map((e) => e.toBottomNavigationBarItem(context)).toList(),
          ),
        ],
      ),
    );
  }
}
