import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/discover/controllers/discovery_segmet_controller.dart';
import 'package:artevo/features/discover/extensions/discovery_segments_extension.dart';
import 'package:artevo/features/discover/presentation/widgets/discover_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(delegate: DiscoverAppBar(), pinned: false),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: columnWidth,
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Consumer(
                  builder: (context, ref, ch) {
                    return ref.watch(selectedDiscoverSegement).view;
                  },
                ),
              ),
            ),
          ),
        )
      ],
    ).animate().fade(duration: const Duration(milliseconds: 500));
  }
}
