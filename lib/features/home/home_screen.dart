import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/features/painting/painting_layout.dart';
import 'package:artevo/features/poem/poem_layout.dart';
import 'package:artevo/features/poll/poll_layout.dart';
import 'package:artevo/features/song/song_layout.dart';
import 'package:artevo/services/admob/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(adInterstitialProvider).when(
          data: (data) {
            try {
              data?.show();
            } catch (e) {
              null;
            }
          },
          error: (error, stackTrace) => null,
          loading: () => null,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, Screens.settings.routeName),
            icon: const Icon(Iconsax.setting),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SongLayout(),
              SizedBox(height: hugePadding),
              PaintingLayot(),
              SizedBox(height: hugePadding),
              PoemLayout(),
              PollLayout(),
              SizedBox(height: hugePadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
