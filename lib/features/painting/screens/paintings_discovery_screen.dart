import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/full_screen_image_viewer.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../core/localization/app_localizations_context.dart';
import '../repository/painting_discovery_repository.dart';
import '../widgets/painting_zoom_dialog.dart';

part 'paintings_discovery_screen_mixin.dart';

class PaintingsDiscoveryScreen extends StatefulWidget {
  const PaintingsDiscoveryScreen({super.key});

  @override
  State<PaintingsDiscoveryScreen> createState() =>
      _PaintingsDiscoveryScreenState();
}

class _PaintingsDiscoveryScreenState extends State<PaintingsDiscoveryScreen>
    with PaintingsDiscoveryMixin {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      key: refreshIndicatorKey,
      onRefresh: () async =>
          PaintingDiscoveryRepository.instance.getPaintings(clearList: true),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: largePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.loc.visualArtworks, style: TextStyles.h1),
                  buillViewTypeChanger(),
                ],
              ),
            ),
          ),
          ListenableBuilder(
            listenable: PaintingDiscoveryRepository.instance,
            builder: (context, child) {
              if (repository.paintings.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: xxLargePadding),
                    child: Text(
                      context.loc.dataIsNotFound,
                      style: TextStyles.b2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                return ValueListenableBuilder(
                  valueListenable: paintingDiscoverViewTypeIsGrid,
                  builder: (context, isGridView, child) {
                    if (isGridView) return paintingGridView();
                    return paintingsListView();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buillViewTypeChanger() {
    return ValueListenableBuilder(
      valueListenable: paintingDiscoverViewTypeIsGrid,
      builder: (context, isGridView, child) => SizedBox(
        height: hugeIconSize,
        width: hugeIconSize,
        child: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 12,
          onPressed: () => paintingDiscoverViewTypeIsGrid.value = !isGridView,
          icon: isGridView
              ? const Icon(Iconsax.grid_5)
              : const Icon(Iconsax.slider_vertical),
        ),
      ),
    );
  }

  Widget paintingGridView() {
    return SliverGrid.builder(
      itemCount: repository.paintings.length,
      itemBuilder: (_, i) => imageWidget(repository.paintings[i]),
      gridDelegate: gridViewDelegate(),
    );
  }

  Widget paintingsListView() {
    return SliverList.separated(
      itemCount: repository.paintings.length,
      itemBuilder: (_, i) => imageWidget(repository.paintings[i]),
      separatorBuilder: (context, index) =>
          const SizedBox(height: smallPadding),
    );
  }

  Widget imageWidget(PaintingContent painting) {
    return InkWell(
      onTap: () =>
          FullScreenImageViewer.open(context: context, painting: painting),
      onLongPress: () => PaintingZoomDialog.show(context, painting),
      child: ImageViewer(url: painting.imageUrl, height: 400),
    );
  }

  SliverQuiltedGridDelegate gridViewDelegate() => SliverQuiltedGridDelegate(
        crossAxisCount: 3,
        mainAxisSpacing: smallPadding,
        crossAxisSpacing: smallPadding,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1)
        ],
      );
}
