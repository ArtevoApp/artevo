import '../../../common/constants/dimens.dart';
import '../controllers/painting_discover_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class PaintingDiscoverViewTypeChanger extends ConsumerWidget {
  const PaintingDiscoverViewTypeChanger({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isGridView = ref.watch(paintingDiscoverViewTypeIsGrid);

    return SizedBox(
      height: hugeIconSize,
      width: hugeIconSize,
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: 12,
        onPressed: () => ref
            .read(paintingDiscoverViewTypeIsGrid.notifier)
            .state = !isGridView,
        icon: isGridView
            ? const Icon(Iconsax.grid_5)
            : const Icon(Iconsax.slider_vertical),
      ),
    );
  }
}
