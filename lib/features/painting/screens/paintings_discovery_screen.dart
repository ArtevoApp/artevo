import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:artevo_package/models/painting_content.dart';

import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../common/widgets/loader.dart';
import '../../../localization/app_localizations_context.dart';
import '../../../screens/_main/nav_bar_controller.dart';
import '../../../screens/discover/discovery_screen_variables.dart';
import '../controllers/painting_discover_controllers.dart';
import '../repository/painting_repository.dart';
import '../widgets/painting_discover_view_type_changer.dart';
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
    discoveryScreenTabIndex = 0;

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: () async => getPaintings(clearList: true),
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: largePadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(context.loc.visualArtworks,
                        style: TextStyles.pageSubtitle),
                  ),
                  const PaintingDiscoverViewTypeChanger(),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: paintings,
            builder: (context, paintingList, child) {
              if (paintingList.isNotEmpty) {
                return Consumer(
                  builder: (context, ref, child) {
                    // if is GridView
                    if (ref.watch(paintingDiscoverViewTypeIsGrid)) {
                      return paintingGridView();
                    }
                    {
                      return paintingsListView();
                    }
                  },
                );
              }
              return isLoading
                  ? const SliverToBoxAdapter(child: Center(child: Loader()))
                  : emtyWidget();
            },
          ),
          moreButton()
        ],
      ),
    );
  }

  Widget paintingGridView() {
    return SliverGrid.builder(
      itemCount: maxPaintingCount,
      gridDelegate: gridViewDelegate(),
      itemBuilder: itemBuilder,
    );
  }

  Widget paintingsListView() {
    return SliverList.separated(
      itemCount: maxPaintingCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (context, index) =>
          const SizedBox(height: smallPadding),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    if (index == paintings.value.length - 3) getPaintings();

    if (index < paintings.value.length) {
      return imageWidget(context, paintings.value.elementAt(index));
    }
    return null;
  }

  Widget imageWidget(BuildContext context, PaintingContent painting) {
    return InkWell(
      onTap: () => PaintingZoomDialog.show(context, painting),
      onLongPress: () => PaintingZoomDialog.show(context, painting),
      child: ImageViewer(
        url: painting.imageUrl,
        height: 400,
      ),
    );
  }

  Widget moreButton() {
    return SliverToBoxAdapter(
      child: ValueListenableBuilder(
          valueListenable: paintings,
          builder: (context, value, child) {
            if (value.length < maxPaintingCount) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(
                  bottom: dialogWidth, top: xLargeIconSize),
              child: CupertinoButton(
                  onPressed: moreButtonOnPressed,
                  child: Text(context.loc.more)),
            );
          }),
    );
  }

  Widget emtyWidget() => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: largePadding),
          child: Text(
            context.loc.contentIsNotFound,
            style: TextStyles.title,
            textAlign: TextAlign.center,
          ),
        ),
      );

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
