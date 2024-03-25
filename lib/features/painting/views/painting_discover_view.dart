import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/painting/controllers/painting_discover_controllers.dart';
import 'package:artevo/features/painting/repo/painting_repository.dart';
import 'package:artevo/features/painting/views/widgets/painting_zoom_dialog.dart';
import 'package:artevo/features/search/enum/search_status.dart';
import 'package:artevo/features/search/extension/search_status_extension.dart';
import 'package:artevo/features/search/search_controllers.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'painting_discover_mixin.dart';

class PaintingDiscoverView extends ConsumerStatefulWidget {
  const PaintingDiscoverView({super.key});

  @override
  ConsumerState<PaintingDiscoverView> createState() =>
      _PaintingDiscoverViewState();
}

class _PaintingDiscoverViewState extends ConsumerState<PaintingDiscoverView>
    with PaintingDiscoverMixin {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async => pagingController.refresh(),
        child: Consumer(builder: (context, ref, child) {
          final isGridView = ref.watch(paintingDiscoverViewTypeIsGrid);

          final searchStatus = ref.watch(searchStatusProvider);

          onSearchStatusChanged(searchStatus);

          if (isGridView) return paintingsGridView();

          return paintingsListView();
        }));
  }

  Widget paintingsGridView() {
    return PagedGridView<int, PaintingContent>(
      pagingController: pagingController,
      showNoMoreItemsIndicatorAsGridChild: false,
      showNewPageErrorIndicatorAsGridChild: false,
      showNewPageProgressIndicatorAsGridChild: false,
      padding: EdgeInsets.all(smallPadding),
      gridDelegate: gridViewDelegate(),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, painting, index) =>
            imageWidget(context, painting),
        firstPageErrorIndicatorBuilder: (context) =>
            Text(context.loc.dataIsNotFound),
        newPageErrorIndicatorBuilder: (context) =>
            Text(context.loc.dataIsNotFound),
      ),
    );
  }

  Widget paintingsListView() {
    return PagedListView<int, PaintingContent>(
      pagingController: pagingController,
      padding: EdgeInsets.all(smallPadding),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, painting, index) => Padding(
            padding: const EdgeInsets.only(bottom: smallPadding),
            child: imageWidget(context, painting)),
        firstPageErrorIndicatorBuilder: (context) =>
            Text(context.loc.dataIsNotFound),
        newPageErrorIndicatorBuilder: (context) =>
            Text(context.loc.dataIsNotFound),
        transitionDuration: 2.seconds,
      ),
    );
  }

  Widget imageWidget(BuildContext context, PaintingContent painting) {
    return InkWell(
      onTap: () => PaintingZoomDialog.show(context, painting),
      onLongPress: () => PaintingZoomDialog.show(context, painting),
      child: ImageViewer(url: painting.imageUrl),
    ).animate().fadeIn(duration: 1.seconds);
  }

  SliverQuiltedGridDelegate gridViewDelegate() {
    return SliverQuiltedGridDelegate(
      crossAxisCount: 3,
      mainAxisSpacing: smallPadding,
      crossAxisSpacing: smallPadding,
      repeatPattern: QuiltedGridRepeatPattern.inverted,
      pattern: [
        QuiltedGridTile(2, 2),
        QuiltedGridTile(1, 1),
        QuiltedGridTile(1, 1)
      ],
    );
  }
}
