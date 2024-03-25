import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/painting/controllers/painting_discover_controllers.dart';
import 'package:artevo/screens/home/controllers/discover_view_controllers.dart';
import 'package:artevo/screens/home/enums/discovery_segments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class PaintingDiscoverViewTypeChanger extends ConsumerWidget {
  const PaintingDiscoverViewTypeChanger({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isGridView = ref.watch(paintingDiscoverViewTypeIsGrid);

    final selectedSegment = ref.watch(selectedDiscoverSegement);

    if (selectedSegment != DiscoverySegments.painting) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: IconButton(
          onPressed: () => ref
              .read(paintingDiscoverViewTypeIsGrid.notifier)
              .state = !isGridView,
          icon: isGridView
              ? Icon(Iconsax.grid_5)
              : Icon(Iconsax.slider_vertical)),
    );
  }
}
