import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/discover/controllers/discovery_segmet_controller.dart';
import 'package:artevo/features/discover/presentation/widgets/discovery_segment_selector.dart';
import 'package:artevo/features/discover/extensions/discovery_segments_extension.dart';
import 'package:artevo/features/discover/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext _, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // background image
        Consumer(builder: (context, ref, ch) {
          return ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: FractionalOffset(0.0, 0.7),
                end: FractionalOffset(0.0, 1),
                colors: [Colors.black, Colors.transparent],
              ).createShader(bounds);
            },
            child: ImageViewer(
                url: ref.watch(selectedDiscoverSegement).imageUrl,
                height: maxExtent),
          );
        }),

        // search bar
        Align(alignment: Alignment.center, child: SearchBarWidget()),

        // discovery segment selector
        if (shrinkOffset < 20) ...{
          Align(
            alignment: Alignment.bottomCenter,
            child: DiscoverySegmentSelector(),
          )
        }
      ],
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
