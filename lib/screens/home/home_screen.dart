import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/features/painting/views/painting_view.dart';
import 'package:artevo/features/poem/view/poem_view.dart';
import 'package:artevo/features/rating/view/content_rating_view.dart';
import 'package:artevo/features/song/view/song_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(appName),
          centerTitle: true,
          actions: [settingsIconButton(context)]),
      body: ListView(
        padding: const EdgeInsets.all(largePadding),
        children: const [
          SongView(),
          SizedBox(height: hugePadding),
          PaintingView(),
          SizedBox(height: hugePadding),
          PoemView(),
          ContectRatingView(),
          SizedBox(height: hugePadding * 2),
        ],
      ),
    );
  }

  IconButton settingsIconButton(BuildContext context) => IconButton(
      onPressed: () => Navigator.pushNamed(context, settingsRoute),
      icon: const Icon(Iconsax.setting));
}
