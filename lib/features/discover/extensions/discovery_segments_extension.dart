import 'package:artevo/common/constants/urls.dart';
import 'package:artevo/features/discover/enums/discovery_segments.dart';
import 'package:artevo/features/discover/presentation/discover_music_segment_view.dart';
import 'package:artevo/features/discover/presentation/discover_painting_segement_view.dart';
import 'package:artevo/features/discover/presentation/discover_poem_segment_view.dart';

import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

extension DiscoverySegmentsExtension on DiscoverySegments {
  String title(BuildContext context) {
    switch (this) {
      case DiscoverySegments.painting:
        return context.loc.painting;
      case DiscoverySegments.music:
        return context.loc.music;
      case DiscoverySegments.poem:
        return context.loc.poem;
    }
  }

  Widget get view {
    switch (this) {
      case DiscoverySegments.painting:
        return const DiscoverPaintingSegmentView();
      case DiscoverySegments.music:
        return const DiscoverMusicSegmentView();
      case DiscoverySegments.poem:
        return const DiscoverPoemSegmentView();
    }
  }

  Icon get icon {
    switch (this) {
      case DiscoverySegments.painting:
        return const Icon(Iconsax.brush_1);
      case DiscoverySegments.music:
        return const Icon(Iconsax.music_dashboard);
      case DiscoverySegments.poem:
        return const Icon(Iconsax.book);
    }
  }

  bool get isEnabled {
    switch (this) {
      case DiscoverySegments.painting:
        return true;
      case DiscoverySegments.music:
        return true;
      case DiscoverySegments.poem:
        return false;
    }
  }

  String get imageUrl {
    switch (this) {
      case DiscoverySegments.painting:
        return paintingSegmentUrl;
      case DiscoverySegments.music:
        return musicSegmentUrl;
      case DiscoverySegments.poem:
        return "";
    }
  }
}
