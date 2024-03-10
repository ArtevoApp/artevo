import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/music/view/music_view.dart';
import 'package:artevo/features/painting/views/painting_view.dart';
import 'package:artevo/features/poem/view/poem_view.dart';
import 'package:artevo/features/rating/view/content_rating_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(largePadding),
        children: const [
          MusicView(),
          SizedBox(height: hugePadding),
          PaintingView(),
          SizedBox(height: hugePadding),
          PoemView(),
          ContectRatingView(),
          SizedBox(height: hugePadding * 2),
        ],
      ).animate().fade(duration: const Duration(milliseconds: 500)),
    );
  }
}
