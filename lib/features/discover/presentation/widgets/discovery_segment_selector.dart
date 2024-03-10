import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/discover/controllers/discovery_segmet_controller.dart';
import 'package:artevo/features/discover/enums/discovery_segments.dart';
import 'package:artevo/features/discover/extensions/discovery_segments_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverySegmentSelector extends ConsumerWidget {
  const DiscoverySegmentSelector({super.key});

  @override
  Widget build(BuildContext _, ref) {
    final selected = ref.watch(selectedDiscoverSegement);

    final segments = DiscoverySegments.values;

    Color backgroundColor =
        Theme.of(_).scaffoldBackgroundColor.withOpacity(.75);

    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: SegmentedButton<DiscoverySegments>(
        selected: <DiscoverySegments>{selected},
        showSelectedIcon: false,
        multiSelectionEnabled: false,
        segments: List.generate(
          segments.length,
          (i) => ButtonSegment<DiscoverySegments>(
            icon: segments[i].icon,
            value: segments[i],
            enabled: segments[i].isEnabled,
            label: Text(segments[i].title(_)),
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backgroundColor)),
        onSelectionChanged: (Set<DiscoverySegments> p0) {
          ref.read(selectedDiscoverSegement.notifier).state = p0.first;
        },
      ),
    );
  }
}
