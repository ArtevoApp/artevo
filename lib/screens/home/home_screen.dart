import 'package:artevo/screens/home/controllers/view_controller.dart';
import 'package:artevo/screens/home/extension/home_screen_view_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    int currentIndex = ref.watch(viewController);

    List<HomeScreenView> views = HomeScreenView.values;

    return Scaffold(
      body: SafeArea(child: views.elementAt(currentIndex).view()),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) => ref.read(viewController.notifier).state = i,
        items: views.map((e) => e.toBottomNavigationBarItem(context)).toList(),
      ),
    );
  }
}
