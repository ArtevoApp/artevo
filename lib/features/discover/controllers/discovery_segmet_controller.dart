import 'package:artevo/features/discover/enums/discovery_segments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDiscoverSegement =
    StateProvider<DiscoverySegments>((ref) => DiscoverySegments.painting);
